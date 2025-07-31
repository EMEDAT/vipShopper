class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final String category;
  final String imageUrl;
  final bool isVipExclusive;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.imageUrl,
    required this.isVipExclusive,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: double.parse(json['price']?.toString() ?? '0'),
      category: json['category'],
      imageUrl: json['image_url'],
      isVipExclusive: json['is_vip_exclusive'] ?? false,
    );
  }

  String get formattedPrice {
    return '\$${price.toStringAsFixed(2).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    )}';
  }

  String get vipBadge {
    return isVipExclusive ? '✨ VIP EXCLUSIVE' : '';
  }

  String get categoryEmoji {
    switch (category.toLowerCase()) {
      case 'watches':
        return '⌚';
      case 'fashion':
        return '👗';
      case 'electronics':
        return '📱';
      case 'automotive':
        return '🚗';
      default:
        return '🛍️';
    }
  }
}