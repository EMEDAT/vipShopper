import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product.dart';
import '../models/cart_item.dart';

class CartService extends ChangeNotifier {
  static final CartService _instance = CartService._internal();
  factory CartService() => _instance;
  CartService._internal();

  List<CartItem> _items = [];
  static const String _cartKey = 'shopping_cart';

  List<CartItem> get items => List.unmodifiable(_items);
  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);
  double get totalAmount => _items.fold(0, (sum, item) => sum + item.totalPrice);
  bool get isEmpty => _items.isEmpty;
  bool get isNotEmpty => _items.isNotEmpty;

  Future<void> loadCart() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartData = prefs.getString(_cartKey);
      
      if (cartData != null) {
        final List<dynamic> cartJson = jsonDecode(cartData);
        _items = cartJson.map((item) => CartItem.fromJson(item)).toList();
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error loading cart: $e');
    }
  }

  Future<void> _saveCart() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartData = jsonEncode(_items.map((item) => item.toJson()).toList());
      await prefs.setString(_cartKey, cartData);
    } catch (e) {
      debugPrint('Error saving cart: $e');
    }
  }

  Future<void> addToCart(Product product, {int quantity = 1}) async {
    final existingIndex = _items.indexWhere((item) => item.productId == product.id);
    
    if (existingIndex >= 0) {
      _items[existingIndex] = _items[existingIndex].copyWith(
        quantity: _items[existingIndex].quantity + quantity,
      );
    } else {
      _items.add(CartItem(
        productId: product.id,
        name: product.name,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        category: product.category,
        isVipExclusive: product.isVipExclusive,
        quantity: quantity,
      ));
    }
    
    await _saveCart();
    notifyListeners();
  }

  Future<void> removeFromCart(int productId) async {
    _items.removeWhere((item) => item.productId == productId);
    await _saveCart();
    notifyListeners();
  }

  Future<void> updateQuantity(int productId, int quantity) async {
    if (quantity <= 0) {
      await removeFromCart(productId);
      return;
    }

    final index = _items.indexWhere((item) => item.productId == productId);
    if (index >= 0) {
      _items[index] = _items[index].copyWith(quantity: quantity);
      await _saveCart();
      notifyListeners();
    }
  }

  Future<void> clearCart() async {
    _items.clear();
    await _saveCart();
    notifyListeners();
  }

  bool isInCart(int productId) {
    return _items.any((item) => item.productId == productId);
  }

  int getItemQuantity(int productId) {
    final item = _items.firstWhere(
      (item) => item.productId == productId,
      orElse: () => CartItem(
        productId: -1,
        name: '',
        description: '',
        price: 0,
        imageUrl: '',
        category: '',
        isVipExclusive: false,
        quantity: 0,
      ),
    );
    return item.productId == -1 ? 0 : item.quantity;
  }

  CartItem? getCartItem(int productId) {
    try {
      return _items.firstWhere((item) => item.productId == productId);
    } catch (e) {
      return null;
    }
  }
}