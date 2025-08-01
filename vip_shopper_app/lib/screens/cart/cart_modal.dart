import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../services/cart_service.dart';
import '../../models/cart_item.dart';

class CartModal extends StatefulWidget {
  const CartModal({super.key});

  @override
  State<CartModal> createState() => _CartModalState();
}

class _CartModalState extends State<CartModal> with TickerProviderStateMixin {
  final CartService _cartService = CartService();
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));
    _slideController.forward();
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

  void _showCheckoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFFFD700).withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.sentiment_very_satisfied, color: Color(0xFFFFD700)),
            ),
            const SizedBox(width: 12),
            Text(
              'Hold Up! 😂',
              style: GoogleFonts.playfairDisplay(
                color: const Color(0xFFFFD700),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFFFD700).withOpacity(0.2)),
              ),
              child: Column(
                children: [
                  Text(
                    'Hey Fernando, it\'s just a test app! 😂',
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No real money involved here.\nJust testing the cart functionality! 🛍️',
                    style: GoogleFonts.montserrat(
                      color: Colors.white70,
                      fontSize: 14,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Your cart total: \$${_cartService.totalAmount.toStringAsFixed(2)}',
                    style: GoogleFonts.montserrat(
                      color: const Color(0xFFFFD700),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Keep Shopping',
              style: GoogleFonts.montserrat(color: Colors.white70),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              _cartService.clearCart();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Cart cleared! Thanks for testing 😄',
                    style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: const Color(0xFFFFD700),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFD700),
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: Text(
              'Clear Cart',
              style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  const Color(0xFFFFD700).withOpacity(0.1),
                  const Color(0xFFFFD700).withOpacity(0.05),
                ],
              ),
              border: Border.all(
                color: const Color(0xFFFFD700).withOpacity(0.2),
                width: 2,
              ),
            ),
            child: const Icon(
              Icons.shopping_cart_outlined,
              size: 60,
              color: Color(0xFFFFD700),
            ),
          ),
          const SizedBox(height: 32),
          Text(
            'Your Cart is Empty',
            style: GoogleFonts.playfairDisplay(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Discover our luxury collection and\nadd items to get started',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 16,
              color: Colors.white70,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFD700),
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
            child: Text(
              'Start Shopping',
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItem(CartItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF1A1A1A),
            const Color(0xFF2A2A2A),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Product Image
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: item.imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.grey[800]!, Colors.grey[700]!],
                      ),
                    ),
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFFFFD700),
                        strokeWidth: 2,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.grey[800]!, Colors.grey[700]!],
                      ),
                    ),
                    child: const Icon(
                      Icons.image_not_supported,
                      color: Colors.white54,
                      size: 32,
                    ),
                  ),
                ),
              ),
            ),
            
            const SizedBox(width: 16),
            
            // Product Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  const SizedBox(height: 4),
                  
                  Text(
                    '\$${item.price.toStringAsFixed(2)} each',
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      color: const Color(0xFFFFD700),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // Quantity Controls
                  Row(
                    children: [
                      IconButton(
                        onPressed: item.quantity > 1 
                            ? () => _cartService.updateQuantity(
                                item.productId,
                                item.quantity - 1,
                              )
                            : null,
                        icon: const Icon(Icons.remove, size: 16),
                        color: item.quantity > 1 ? Colors.white : Colors.white38,
                        constraints: const BoxConstraints.tightFor(width: 32, height: 32),
                        padding: EdgeInsets.zero,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: const Color(0xFFFFD700).withOpacity(0.3),
                          ),
                        ),
                        child: Text(
                          item.quantity.toString(),
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => _cartService.updateQuantity(
                          item.productId,
                          item.quantity + 1,
                        ),
                        icon: const Icon(Icons.add, size: 16),
                        color: Colors.white,
                        constraints: const BoxConstraints.tightFor(width: 32, height: 32),
                        padding: EdgeInsets.zero,
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Total Price
                  Text(
                    '\$${item.totalPrice.toStringAsFixed(2)}',
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Remove Button
                  IconButton(
                    onPressed: () => _cartService.removeFromCart(item.productId),
                    icon: const Icon(Icons.delete_outline),
                    color: Colors.red.withOpacity(0.8),
                    constraints: const BoxConstraints.tightFor(width: 32, height: 32),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (context, scrollController) {
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF1A1A1A),
                  Color(0xFF000000),
                ],
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: Column(
              children: [
                // Handle Bar
                Container(
                  margin: const EdgeInsets.only(top: 12),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                
                // Header
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFD700).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.shopping_cart,
                          color: Color(0xFFFFD700),
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Shopping Cart',
                              style: GoogleFonts.playfairDisplay(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            ListenableBuilder(
                              listenable: _cartService,
                              builder: (context, _) {
                                return Text(
                                  '${_cartService.itemCount} items • \$${_cartService.totalAmount.toStringAsFixed(2)}',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 14,
                                    color: const Color(0xFFFFD700),
                                    fontWeight: FontWeight.w600,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.close, color: Colors.white70),
                      ),
                    ],
                  ),
                ),
                
                // Cart Content
                Expanded(
                  child: ListenableBuilder(
                    listenable: _cartService,
                    builder: (context, _) {
                      if (_cartService.isEmpty) {
                        return _buildEmptyCart();
                      }
                      
                      return Column(
                        children: [
                          // Cart Items
                          Expanded(
                            child: ListView.builder(
                              controller: scrollController,
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              itemCount: _cartService.items.length,
                              itemBuilder: (context, index) {
                                return _buildCartItem(_cartService.items[index]);
                              },
                            ),
                          ),
                          
                          // Checkout Section
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.black.withOpacity(0.8),
                                  Colors.black,
                                ],
                              ),
                              border: Border(
                                top: BorderSide(
                                  color: Colors.white.withOpacity(0.1),
                                ),
                              ),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Total Amount',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      '\$${_cartService.totalAmount.toStringAsFixed(2)}',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xFFFFD700),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: _showCheckoutDialog,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFFFFD700),
                                      foregroundColor: Colors.black,
                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      elevation: 8,
                                      shadowColor: const Color(0xFFFFD700).withOpacity(0.3),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.shopping_bag, size: 20),
                                        const SizedBox(width: 8),
                                        Text(
                                          'Proceed to Checkout',
                                          style: GoogleFonts.montserrat(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}