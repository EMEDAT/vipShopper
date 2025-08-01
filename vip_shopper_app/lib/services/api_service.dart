import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product.dart';
import '../models/user.dart';

class ApiService {
  static const String baseUrl = 'http://127.0.0.1:8000/api';

  static Future<Map<String, String>> getHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token') ?? '';
    
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token.isNotEmpty) 'Authorization': 'Bearer $token',
    };
  }

  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }

  static Future<bool> hasValidToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    return token != null && token.isNotEmpty;
  }

  static Future<Map<String, dynamic>> register(String name, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: await getHeaders(),
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
        }),
      );

      final data = jsonDecode(response.body);
      
      if (response.statusCode == 201) {
        await saveToken(data['token']);
        return {
          'success': true,
          'user': User.fromJson(data),
          'message': data['message'] ?? 'Registration successful'
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Registration failed'
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Network error: $e'};
    }
  }

  static Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: await getHeaders(),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      final data = jsonDecode(response.body);
      
      if (response.statusCode == 200) {
        await saveToken(data['token']);
        return {
          'success': true,
          'user': User.fromJson(data),
          'message': data['message'] ?? 'Login successful'
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Login failed'
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Network error: $e'};
    }
  }

  static Future<Map<String, dynamic>> getCurrentUser() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/user'),
        headers: await getHeaders(),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // Return simplified user data for tier checking
        return {
          'success': true,
          'id': data['user']['id'],
          'name': data['user']['name'],
          'email': data['user']['email'],
          'vip_tier': data['user']['vip_tier'] ?? 'bronze',
          'total_spent': double.parse(data['user']['total_spent']?.toString() ?? '0'),
          'preferences': data['user']['preferences'] ?? [],
          'vip_status': data['vip_status'] ?? {}
        };
      } else if (response.statusCode == 401) {
        await clearToken();
        return {'success': false, 'message': 'Authentication expired'};
      } else {
        final data = jsonDecode(response.body);
        return {'success': false, 'message': data['message'] ?? 'Failed to get user'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Network error: $e'};
    }
  }

  static Future<bool> logout() async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/logout'),
        headers: await getHeaders(),
      );
      
      await clearToken();
      return response.statusCode == 200;
    } catch (e) {
      await clearToken();
      return false;
    }
  }

  static Future<List<Product>> getProducts() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/products'),
        headers: await getHeaders(),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final products = data['products']['data'] as List;
        return products.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // 🔥 CRITICAL FIX: Updated getVipProducts method to handle different response structures
  static Future<Map<String, dynamic>> getVipProducts() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/products/vip'),
        headers: await getHeaders(),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        
        // FIXED: Handle both paginated and non-paginated responses
        List<Product> products = [];
        
        if (data['products'] != null) {
          if (data['products'] is List) {
            // Direct list (for denied access - should be empty)
            products = (data['products'] as List)
                .map((json) => Product.fromJson(json))
                .toList();
          } else if (data['products']['data'] != null) {
            // Paginated response (for VIP users)
            products = (data['products']['data'] as List)
                .map((json) => Product.fromJson(json))
                .toList();
          }
        }
        
        return {
          'success': true,
          'products': products,
          'access_level': data['access_level'] ?? 'full',
          'message': data['message'] ?? 'VIP products loaded',
          'vip_tier': data['vip_tier'] ?? 'gold',
          'product_limit': data['product_limit'] ?? 30,
          'total_vip_products': data['total_vip_products'] ?? products.length,
          'upgrade_benefits': data['upgrade_benefits']
        };
      } else if (response.statusCode == 403) {
        // Access denied for regular users
        final data = jsonDecode(response.body);
        return {
          'success': false,
          'products': <Product>[],
          'access_level': data['access_level'] ?? 'denied',
          'message': data['message'] ?? 'VIP access required',
          'vip_tier': data['vip_tier'] ?? 'bronze',
          'product_limit': 0,
          'total_vip_products': data['total_vip_products'] ?? 0,
          'upgrade_benefits': data['upgrade_benefits']
        };
      } else if (response.statusCode == 401) {
        await clearToken();
        return {
          'success': false,
          'products': <Product>[],
          'access_level': 'denied',
          'message': 'Please login to access VIP products',
          'vip_tier': 'guest',
          'product_limit': 0
        };
      } else {
        throw Exception('Failed to load VIP products');
      }
    } catch (e) {
      return {
        'success': false,
        'products': <Product>[],
        'access_level': 'denied',
        'message': 'Network error: $e',
        'vip_tier': 'bronze',
        'product_limit': 0
      };
    }
  }

  static Future<Map<String, dynamic>> aiSearch(String query) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/ai/search'),
        headers: await getHeaders(),
        body: jsonEncode({'query': query}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final products = (data['products'] as List?)
            ?.map((json) => Product.fromJson(json))
            .toList() ?? [];
        
        return {
          'success': true,
          'products': products,
          'message': data['message'] ?? 'Search completed',
          'insights': data['insights'] ?? {}
        };
      } else {
        final data = jsonDecode(response.body);
        return {
          'success': false,
          'products': <Product>[],
          'message': data['message'] ?? 'Search failed'
        };
      }
    } catch (e) {
      return {
        'success': false,
        'products': <Product>[],
        'message': 'Network error: $e'
      };
    }
  }

  static Future<Map<String, dynamic>> getRecommendations() async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/ai/recommendations'),
        headers: await getHeaders(),
        body: jsonEncode({}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final products = (data['recommendations'] as List?)
            ?.map((json) => Product.fromJson(json))
            .toList() ?? [];
        
        return {
          'success': true,
          'products': products,
          'message': data['message'] ?? 'Recommendations generated',
          'reasoning': data['ai_reasoning'] ?? {}
        };
      } else {
        final data = jsonDecode(response.body);
        return {
          'success': false,
          'products': <Product>[],
          'message': data['message'] ?? 'Failed to get recommendations'
        };
      }
    } catch (e) {
      return {
        'success': false,
        'products': <Product>[],
        'message': 'Network error: $e'
      };
    }
  }

  static Future<Map<String, dynamic>> aiChat(String message) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/ai/chat'),
        headers: await getHeaders(),
        body: jsonEncode({'message': message}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'success': true,
          'response': data['ai_response'] ?? 'No response',
          'message': data['message'] ?? 'Chat completed'
        };
      } else {
        final data = jsonDecode(response.body);
        return {
          'success': false,
          'response': '',
          'message': data['message'] ?? 'Chat failed'
        };
      }
    } catch (e) {
      return {
        'success': false,
        'response': '',
        'message': 'Network error: $e'
      };
    }
  }

  // Helper method to check user tier without full user object
  static Future<String> getUserTier() async {
    try {
      final userInfo = await getCurrentUser();
      return userInfo['success'] ? userInfo['vip_tier'] : 'bronze';
    } catch (e) {
      return 'bronze';
    }
  }

  // Helper method to check VIP access
  static Future<bool> hasVipAccess() async {
    try {
      final tier = await getUserTier();
      return ['gold', 'platinum'].contains(tier);
    } catch (e) {
      return false;
    }
  }

  // Get product limit based on user tier
  static Future<int> getProductLimit() async {
    try {
      final hasVip = await hasVipAccess();
      return hasVip ? 30 : 15;
    } catch (e) {
      return 15;
    }
  }

  // Get search result limit based on user tier  
  static Future<int> getSearchLimit() async {
    try {
      final hasVip = await hasVipAccess();
      return hasVip ? 24 : 12;
    } catch (e) {
      return 12;
    }
  }
}