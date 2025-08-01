import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../models/product.dart';

class ApiService {
  static const String baseUrl = 'https://vipshopper-production.up.railway.app/api';
  
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }
  
  static Future<void> storeToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }
  
  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }
  
  static Future<Map<String, String>> getHeaders() async {
    final token = await getToken();
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  static Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      print('🚀 Registration attempt: $baseUrl/register');
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: await getHeaders(),
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
        }),
      );

      print('📊 Registration status: ${response.statusCode}');
      print('📦 Registration response: ${response.body}');

      final data = jsonDecode(response.body);
      
      if (response.statusCode == 201 || response.statusCode == 200) {
        await storeToken(data['token']);
        return {'success': true, 'user': User.fromJson(data)};
      } else {
        return {'success': false, 'message': data['message'] ?? 'Registration failed'};
      }
    } catch (e) {
      print('❌ Registration error: $e');
      return {'success': false, 'message': 'Network error: $e'};
    }
  }

  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      print('🔐 Login attempt: $baseUrl/login');
      print('📧 Email: $email');
      
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: await getHeaders(),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      print('📊 Login status: ${response.statusCode}');
      print('📦 Login response: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        await storeToken(data['token']);
        return {'success': true, 'user': User.fromJson(data)};
      } else {
        final data = jsonDecode(response.body);
        return {'success': false, 'message': data['message'] ?? 'Login failed'};
      }
    } catch (e) {
      print('❌ Login error: $e');
      return {'success': false, 'message': 'Network error: $e'};
    }
  }

  // CRITICAL FIX: This method was missing and causing the platinum UI bug
  static Future<Map<String, dynamic>> getCurrentUser() async {
    try {
      print('👤 Getting current user: $baseUrl/user');
      final response = await http.get(
        Uri.parse('$baseUrl/user'),
        headers: await getHeaders(),
      );

      print('📊 Get user status: ${response.statusCode}');
      print('📦 Get user response: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'success': true,
          'user': User.fromApiResponse(data['user']),
          'vip_status': data['vip_status']
        };
      } else if (response.statusCode == 401) {
        await clearToken();
        return {'success': false, 'message': 'Authentication expired'};
      } else {
        final data = jsonDecode(response.body);
        return {'success': false, 'message': data['message'] ?? 'Failed to get user'};
      }
    } catch (e) {
      print('❌ Get user error: $e');
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

  static Future<List<Product>> getVipProducts() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/products/vip'),
        headers: await getHeaders(),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final products = data['products']['data'] as List;
        return products.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load VIP products');
      }
    } catch (e) {
      throw Exception('Network error: $e');
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
        final products = data['products'] as List;
        return {
          'success': true,
          'products': products.map((json) => Product.fromJson(json)).toList(),
          'insights': data['ai_insights'],
          'message': data['message'],
        };
      } else {
        return {'success': false, 'message': 'Search failed'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Network error: $e'};
    }
  }

  static Future<Map<String, dynamic>> aiRecommendations() async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/ai/recommendations'),
        headers: await getHeaders(),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final products = data['products'] as List;
        return {
          'success': true,
          'products': products.map((json) => Product.fromJson(json)).toList(),
          'insights': data['ai_insights'],
          'recommendations': data['recommendations'],
        };
      } else {
        return {'success': false, 'message': 'Failed to get recommendations'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Network error: $e'};
    }
  }

  static Future<Map<String, dynamic>> aiChat(String message) async {
    try {
      print('🤖 AI Chat request: $message');
      final response = await http.post(
        Uri.parse('$baseUrl/ai/chat'),
        headers: await getHeaders(),
        body: jsonEncode({'message': message}),
      );

      print('📊 AI Chat status: ${response.statusCode}');
      print('📦 AI Chat response: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'success': true,
          'response': data['ai_response'],
          'user_message': data['user_message'],
        };
      } else {
        return {
          'success': false,
          'response': 'AI concierge is temporarily unavailable.'
        };
      }
    } catch (e) {
      print('❌ AI Chat error: $e');
      return {
        'success': false,
        'response': 'Unable to connect to AI concierge.'
      };
    }
  }
}