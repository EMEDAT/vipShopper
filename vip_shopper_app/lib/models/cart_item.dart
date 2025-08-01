class CartItem {
  final int productId;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String category;
  final bool isVipExclusive;
  int quantity;

  CartItem({
    required this.productId,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.isVipExclusive,
    this.quantity = 1,
  });

  double get totalPrice => price * quantity;

  CartItem copyWith({
    int? productId,
    String? name,
    String? description,
    double? price,
    String? imageUrl,
    String? category,
    bool? isVipExclusive,
    int? quantity,
  }) {
    return CartItem(
      productId: productId ?? this.productId,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      isVipExclusive: isVipExclusive ?? this.isVipExclusive,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'category': category,
      'isVipExclusive': isVipExclusive,
      'quantity': quantity,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      productId: json['productId'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      imageUrl: json['imageUrl'],
      category: json['category'],
      isVipExclusive: json['isVipExclusive'],
      quantity: json['quantity'],
    );
  }
}