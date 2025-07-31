import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../models/product.dart';

class ApiService {
  // CHANGED: Use localhost instead of 127.0.0.1 to match Flutter web domain
  static const String baseUrl = 'http://localhost:8000/api';
  
  // Get stored auth token
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }
  
  // Store auth token
  static Future<void> storeToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }
  
  // Clear auth token
  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }
  
  // Get headers with auth token
  static Future<Map<String, String>> getHeaders() async {
    final token = await getToken();
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  // Register new user
  static Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      print('Attempting registration to: $baseUrl/register');
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: await getHeaders(),
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
        }),
      );

      print('Registration response status: ${response.statusCode}');
      print('Registration response body: ${response.body}');

      final data = jsonDecode(response.body);
      
      if (response.statusCode == 201 || response.statusCode == 200) {
        await storeToken(data['token']);
        return {'success': true, 'user': User.fromJson(data)};
      } else {
        return {'success': false, 'message': data['message'] ?? 'Registration failed'};
      }
    } catch (e) {
      print('Registration error: $e');
      return {'success': false, 'message': 'Network error: $e'};
    }
  }

  // Login user
  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      print('Attempting login to: $baseUrl/login');
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: await getHeaders(),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      print('Login response status: ${response.statusCode}');
      print('Login response body: ${response.body}');

      final data = jsonDecode(response.body);
      
      if (response.statusCode == 200) {
        await storeToken(data['token']);
        return {'success': true, 'user': User.fromJson(data)};
      } else {
        return {'success': false, 'message': data['message'] ?? 'Login failed'};
      }
    } catch (e) {
      print('Login error: $e');
      return {'success': false, 'message': 'Network error: $e'};
    }
  }

  // Logout user
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

  // Get products
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

  // Get VIP products
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

  // AI Search
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

  // AI Recommendations (requires auth)
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
}