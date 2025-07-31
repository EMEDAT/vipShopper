import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../services/api_service.dart';
import '../../models/product.dart';
import '../../widgets/product_card.dart';

class VipProductsScreen extends StatefulWidget {
  const VipProductsScreen({super.key});

  @override
  State<VipProductsScreen> createState() => _VipProductsScreenState();
}

class _VipProductsScreenState extends State<VipProductsScreen> {
  List<Product> _vipProducts = [];
  bool _isLoading = true;
  String _error = '';
  bool _hasAccess = false;

  @override
  void initState() {
    super.initState();
    _loadVipProducts();
  }

  Future<void> _loadVipProducts() async {
    try {
      setState(() {
        _isLoading = true;
        _error = '';
      });

      final products = await ApiService.getVipProducts();
      
      setState(() {
        _vipProducts = products;
        _hasAccess = true;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _hasAccess = false;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            backgroundColor: Colors.black,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'VIP EXCLUSIVES',
                style: GoogleFonts.playfairDisplay(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFFFD700),
                ),
              ),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF000000),
                      Color(0xFF1A1A1A),
                    ],
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const RadialGradient(
                            colors: [
                              Color(0xFFFFD700),
                              Color(0xFFB8860B),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFFFD700).withOpacity(0.5),
                              blurRadius: 15,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.diamond,
                          size: 40,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'FOR DISTINGUISHED MEMBERS ONLY',
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          color: Colors.white70,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          
          if (_isLoading)
            const SliverFillRemaining(
              child: Center(
                child: CircularProgressIndicator(
                  color: Color(0xFFFFD700),
                ),
              ),
            )
          else if (!_hasAccess)
            SliverFillRemaining(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFFFFD700).withOpacity(0.3),
                          width: 2,
                        ),
                      ),
                      child: const Icon(
                        Icons.lock_outlined,
                        size: 60,
                        color: Color(0xFFFFD700),
                      ),
                    ),
                    
                    const SizedBox(height: 30),
                    
                    Text(
                      'VIP Access Required',
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFFFD700),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    
                    const SizedBox(height: 16),
                    
                    Text(
                      'Upgrade to Gold or Platinum membership to access our exclusive collection of luxury products.',
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        color: Colors.white70,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    
                    const SizedBox(height: 30),
                    
                    // Upgrade Benefits
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFFFFD700).withOpacity(0.1),
                            const Color(0xFFB8860B).withOpacity(0.1),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFFFFD700).withOpacity(0.3),
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            '👑 Gold Membership Benefits',
                            style: GoogleFonts.montserrat(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFFFFD700),
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildBenefitRow('15% cashback on all purchases'),
                          _buildBenefitRow('Access to VIP exclusive products'),
                          _buildBenefitRow('Priority customer support'),
                          _buildBenefitRow('Free shipping worldwide'),
                          const SizedBox(height: 16),
                          Text(
                            'Spend \$5,000 to unlock Gold status',
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              color: Colors.white60,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 30),
                    
                    ElevatedButton(
                      onPressed: () {
                        // Navigate back to regular products
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'VIEW REGULAR COLLECTION',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          else if (_vipProducts.isEmpty)
            SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.diamond_outlined,
                      size: 64,
                      color: Color(0xFFFFD700),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No VIP products available',
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.75,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final product = _vipProducts[index];
                    return ProductCard(product: product);
                  },
                  childCount: _vipProducts.length,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBenefitRow(String benefit) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle,
            color: Color(0xFFFFD700),
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              benefit,
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}