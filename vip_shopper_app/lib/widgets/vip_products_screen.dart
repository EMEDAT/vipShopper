import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/api_service.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';
import '../utils/responsive_grid.dart';

class VipProductsScreen extends StatefulWidget {
  const VipProductsScreen({super.key});

  @override
  State<VipProductsScreen> createState() => _VipProductsScreenState();
}

class _VipProductsScreenState extends State<VipProductsScreen>
    with TickerProviderStateMixin {
  List<Product> _vipProducts = [];
  bool _isLoading = true;
  String _error = '';
  String _userTier = 'bronze';
  late AnimationController _slideController;

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _loadVipProducts();
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }


  Future<void> _loadVipProducts() async {
    try {
      setState(() {
        _isLoading = true;
        _error = '';
      });

      final result = await ApiService.getVipProducts();
      if (mounted) {
        setState(() {
          // ApiService.getVipProducts() always returns Map<String, dynamic>
          final products = result['products'] as List<dynamic>? ?? [];
          _vipProducts = products.map((json) => Product.fromJson(json)).toList();
          _userTier = result['vip_tier'] ?? 'bronze';
          _isLoading = false;
        });
        
        if (_vipProducts.isNotEmpty) {
          _slideController.forward();
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  bool get _hasVipAccess => ['gold', 'platinum'].contains(_userTier);

  Widget _buildAccessDenied() {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(32),
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1A1A1A),
              const Color(0xFF2A2A2A),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFFFFD700).withOpacity(0.3),
            width: 2,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFFFFD700).withOpacity(0.2),
                    const Color(0xFFFFD700).withOpacity(0.1),
                  ],
                ),
                border: Border.all(
                  color: const Color(0xFFFFD700).withOpacity(0.5),
                  width: 2,
                ),
              ),
              child: const Icon(
                Icons.lock_outline,
                size: 40,
                color: Color(0xFFFFD700),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Limited VIP Access',
              style: GoogleFonts.playfairDisplay(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Upgrade to Gold or Platinum\nfor full VIP product access',
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                fontSize: 16,
                color: Colors.white70,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Current Tier: ${_userTier.toUpperCase()}',
              style: GoogleFonts.montserrat(
                fontSize: 14,
                color: const Color(0xFFFFD700),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: RefreshIndicator(
        onRefresh: _loadVipProducts,
        color: const Color(0xFFFFD700),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              expandedHeight: ResponsiveGrid.getExpandedHeight(context),
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
                  fontSize: ResponsiveGrid.getTitleFontSize(context),
                ),
              ),
              centerTitle: false,
                flexibleSpace: FlexibleSpaceBar(
                background: Container(
                    decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xFF000000), Color(0xFF1A1A1A), Color(0xFF2A2A2A)],
                    ),
                    ),
                    child: SafeArea(
                    child: LayoutBuilder(
                        builder: (context, constraints) {
                        // Calculate available space
                        final availableHeight = constraints.maxHeight;
                        final isSmallScreen = availableHeight < 180;
                        
                        return Padding(
                            padding: EdgeInsets.only(
                            top: availableHeight * 0.2, // Dynamic top based on available height
                            left: 16,
                            right: 16,
                            bottom: 8,
                            ),
                            child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                                Container(
                                padding: EdgeInsets.all(isSmallScreen ? 8 : 12),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: const RadialGradient(
                                    colors: [Color(0xFFFFD700), Color(0xFFB8860B)],
                                    ),
                                ),
                                child: Icon(
                                    Icons.diamond,
                                    size: isSmallScreen ? 16 : 24,
                                    color: Colors.black,
                                ),
                                ),
                                SizedBox(width: isSmallScreen ? 8 : 16),
                                Expanded(
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                    Text(
                                        'Rich and',
                                        style: GoogleFonts.montserrat(
                                        color: Colors.white70,
                                        fontSize: isSmallScreen ? 12 : 14,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                        'EXCLUSIVE ACCESS',
                                        style: GoogleFonts.playfairDisplay(
                                        color: const Color(0xFFFFD700),
                                        fontSize: isSmallScreen ? 14 : 16,
                                        fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                    ),
                                    ],
                                ),
                                ),
                            ],
                            ),
                        );
                        },
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
            else if (_error.isNotEmpty)
              SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 64,
                        color: Colors.red.withOpacity(0.7),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Something went wrong',
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _error,
                        style: GoogleFonts.montserrat(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: _loadVipProducts,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFFD700),
                          foregroundColor: Colors.black,
                        ),
                        child: Text(
                          'Try Again',
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
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
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: ResponsiveGrid.getCrossAxisCount(context),
                crossAxisSpacing: ResponsiveGrid.getSpacing(context),
                mainAxisSpacing: ResponsiveGrid.getSpacing(context),
                childAspectRatio: ResponsiveGrid.getChildAspectRatio(context),
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
      ),
    );
  }
}