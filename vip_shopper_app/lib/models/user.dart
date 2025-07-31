import 'package:flutter/material.dart';

class User {
  final int id;
  final String name;
  final String email;
  final String vipTier;
  final double totalSpent;
  final List<String> preferences;
  final String token;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.vipTier,
    required this.totalSpent,
    required this.preferences,
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['user']['id'],
      name: json['user']['name'],
      email: json['user']['email'],
      vipTier: json['user']['vip_tier'] ?? 'bronze',
      totalSpent: double.parse(json['user']['total_spent']?.toString() ?? '0'),
      preferences: json['user']['preferences'] != null 
          ? List<String>.from(json['user']['preferences'])
          : [],
      token: json['token'],
    );
  }

  // VIP tier colors and benefits
  Color get tierColor {
    switch (vipTier.toLowerCase()) {
      case 'platinum':
        return const Color(0xFFE5E4E2); // Platinum
      case 'gold':
        return const Color(0xFFFFD700); // Gold
      case 'silver':
        return const Color(0xFFC0C0C0); // Silver
      default:
        return const Color(0xFFCD7F32); // Bronze
    }
  }

  String get tierEmoji {
    switch (vipTier.toLowerCase()) {
      case 'platinum':
        return '👑';
      case 'gold':
        return '🥇';
      case 'silver':
        return '🥈';
      default:
        return '🥉';
    }
  }

  List<String> get tierBenefits {
    switch (vipTier.toLowerCase()) {
      case 'platinum':
        return [
          '20% cashback on all purchases',
          'Free shipping worldwide',
          'Priority support',
          'Exclusive products access',
          'Personal shopper service'
        ];
      case 'gold':
        return [
          '15% cashback on all purchases',
          'Free shipping',
          'Priority support',
          'Exclusive products access'
        ];
      case 'silver':
        return [
          '10% cashback on all purchases',
          'Free shipping',
          'Priority support'
        ];
      default:
        return [
          '5% cashback on purchases',
          'Free shipping over \$100'
        ];
    }
  }

  bool get canAccessVipProducts {
    return vipTier.toLowerCase() == 'gold' || vipTier.toLowerCase() == 'platinum';
  }
}