import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../services/api_service.dart';
import '../../models/product.dart';
import '../../widgets/product_card.dart';

class VipProductsScreen extends StatefulWidget {
  final VoidCallback? onNavigateToHome;
  
  const VipProductsScreen({
    super.key,
    this.onNavigateToHome,
  });

  @override
  State<VipProductsScreen> createState() => _VipProductsScreenState();
}

class _VipProductsScreenState extends State<VipProductsScreen> 
    with TickerProviderStateMixin {
  List<Product> _vipProducts = [];
  bool _isLoading = true;
  String _error = '';
  bool _hasAccess = false;
  late AnimationController _shimmerController;
  late AnimationController _slideController;

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _loadVipProducts();
  }

  void _initAnimations() {
    _shimmerController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
    
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  Future<void> _loadVipProducts() async {
    try {
      setState(() {
        _isLoading = true;
        _error = '';
      });

      final products = await ApiService.getVipProducts();
      
      if (mounted) {
        setState(() {
          _vipProducts = products;
          _hasAccess = true;
          _isLoading = false;
        });
        _slideController.forward();
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _hasAccess = false;
          _isLoading = false;
        });
        _slideController.forward();
      }
    }
  }

  Widget _buildShimmerEffect() {
    return AnimatedBuilder(
      animation: _shimmerController,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(-1.0, -0.3),
              end: Alignment(1.0, 0.3),
              colors: [
                const Color(0xFFFFD700).withOpacity(0.1),
                const Color(0xFFFFD700).withOpacity(0.3),
                const Color(0xFFFFD700).withOpacity(0.1),
              ],
              stops: [
                0.0,
                _shimmerController.value,
                1.0,
              ],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
        );
      },
    );
  }

  Widget _buildBenefitRow(String benefit, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFFFD700).withOpacity(0.2),
            ),
            child: Icon(
              icon,
              color: const Color(0xFFFFD700),
              size: 16,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              benefit,
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 220,
            floating: false,
            pinned: true,
            elevation: 0,
            backgroundColor: Colors.black,
            automaticallyImplyLeading: false,
            title: Text(
              'VIP EXCLUSIVES',
              style: GoogleFonts.playfairDisplay(
                fontWeight: FontWeight.bold,
                color: const Color(0xFFFFD700),
                fontSize: 20,
              ),
            ),
            centerTitle: false,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF000000),
                      Color(0xFF1A1A1A),
                      Color(0xFF2A2A2A),
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 80, left: 24, right: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: const RadialGradient(
                                      colors: [Color(0xFFFFD700), Color(0xFFB8860B)],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFFFFD700).withOpacity(0.4),
                                        blurRadius: 20,
                                        spreadRadius: 2,
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.diamond,
                                    size: 32,
                                    color: Colors.black,
                                  ),
                                ),
                                if (!_hasAccess && !_isLoading)
                                  Positioned.fill(
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.black54,
                                      ),
                                      child: const Icon(
                                        Icons.lock,
                                        color: Color(0xFFFFD700),
                                        size: 20,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'FOR DISTINGUISHED MEMBERS',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 11,
                                      color: Colors.white70,
                                      letterSpacing: 2,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    _hasAccess 
                                        ? 'Exclusive luxury collection'
                                        : 'Upgrade required for access',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      color: const Color(0xFFFFD700),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          
          if (_isLoading)
            SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: Stack(
                        children: [
                          _buildShimmerEffect(),
                          Center(
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0xFFFFD700).withOpacity(0.1),
                              ),
                              child: const CircularProgressIndicator(
                                color: Color(0xFFFFD700),
                                strokeWidth: 3,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      'Accessing VIP Collection...',
                      style: GoogleFonts.montserrat(
                        color: Colors.white70,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else if (!_hasAccess)
            SliverToBoxAdapter(
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.3),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: _slideController,
                  curve: Curves.easeOutCubic,
                )),
                child: FadeTransition(
                  opacity: _slideController,
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        const SizedBox(height: 40),
                        
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                const Color(0xFFFFD700).withOpacity(0.1),
                                const Color(0xFFB8860B).withOpacity(0.1),
                              ],
                            ),
                            border: Border.all(
                              color: const Color(0xFFFFD700).withOpacity(0.3),
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFFFD700).withOpacity(0.2),
                                blurRadius: 30,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.lock_outlined,
                            size: 48,
                            color: Color(0xFFFFD700),
                          ),
                        ),
                        
                        const SizedBox(height: 32),
                        
                        Text(
                          'VIP Access Required',
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 32,
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
                            height: 1.6,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        
                        const SizedBox(height: 40),
                        
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                const Color(0xFFFFD700).withOpacity(0.1),
                                const Color(0xFFB8860B).withOpacity(0.05),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: const Color(0xFFFFD700).withOpacity(0.3),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFFFD700).withOpacity(0.1),
                                blurRadius: 20,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.workspace_premium,
                                    color: Color(0xFFFFD700),
                                    size: 24,
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    'Gold Membership Benefits',
                                    style: GoogleFonts.playfairDisplay(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFFFFD700),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),
                              
                              _buildBenefitRow('15% cashback on all purchases', Icons.account_balance_wallet),
                              _buildBenefitRow('Access to VIP exclusive products', Icons.diamond),
                              _buildBenefitRow('Priority customer support', Icons.headset_mic),
                              _buildBenefitRow('Free shipping worldwide', Icons.local_shipping),
                              
                              const SizedBox(height: 20),
                              
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFD700).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  'Spend \$5,000 to unlock Gold status',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 13,
                                    color: Colors.white60,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        const SizedBox(height: 40),
                        
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: widget.onNavigateToHome,
                            icon: const Icon(Icons.home),
                            label: Text(
                              'VIEW REGULAR COLLECTION',
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFFD700),
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 4,
                              shadowColor: const Color(0xFFFFD700).withOpacity(0.3),
                            ),
                          ),
                        ),
                        
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ),
            )
          else if (_vipProducts.isEmpty)
            SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFFFD700).withOpacity(0.1),
                      ),
                      child: const Icon(
                        Icons.diamond_outlined,
                        size: 48,
                        color: Color(0xFFFFD700),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'No VIP products available',
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Check back soon for exclusive releases',
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        color: Colors.white70,
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
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: Offset(0, 0.3 + (index * 0.1)),
                        end: Offset.zero,
                      ).animate(CurvedAnimation(
                        parent: _slideController,
                        curve: Interval(
                          (index * 0.1).clamp(0.0, 1.0),
                          1.0,
                          curve: Curves.easeOutCubic,
                        ),
                      )),
                      child: FadeTransition(
                        opacity: CurvedAnimation(
                          parent: _slideController,
                          curve: Interval(
                            (index * 0.1).clamp(0.0, 1.0),
                            1.0,
                          ),
                        ),
                        child: ProductCard(product: product),
                      ),
                    );
                  },
                  childCount: _vipProducts.length,
                ),
              ),
            ),
        ],
      ),
    );
  }
}