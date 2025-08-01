import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../services/api_service.dart';
import '../auth/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> 
    with TickerProviderStateMixin {
  String _aiResponse = '';
  bool _isLoadingAI = false;
  final _chatController = TextEditingController();
  late AnimationController _profileAnimationController;
  late AnimationController _cardAnimationController;
  late Animation<double> _profileAnimation;
  late Animation<double> _cardAnimation;

  @override
  void initState() {
    super.initState();
    _initAnimations();
  }

  void _initAnimations() {
    _profileAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    _cardAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _profileAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _profileAnimationController, curve: Curves.easeOutCubic),
    );

    _cardAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _cardAnimationController, curve: Curves.easeOutBack),
    );

    _profileAnimationController.forward();
    Future.delayed(const Duration(milliseconds: 300), () {
      _cardAnimationController.forward();
    });
  }

  @override
  void dispose() {
    _chatController.dispose();
    _profileAnimationController.dispose();
    _cardAnimationController.dispose();
    super.dispose();
  }

  Future<void> _sendAIMessage(String message) async {
    if (message.trim().isEmpty) return;

    setState(() {
      _isLoadingAI = true;
    });

    try {
      final result = await ApiService.aiChat(message);

      if (mounted) {
        setState(() {
          _isLoadingAI = false;
          if (result['success']) {
            _aiResponse = result['response'];
          } else {
            _aiResponse = 'AI concierge is temporarily unavailable. Please try again later.';
          }
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoadingAI = false;
          _aiResponse = 'Connection error. Please check your network and try again.';
        });
      }
    }

    _chatController.clear();
  }

  Future<void> _logout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.logout, color: const Color(0xFFFFD700), size: 24),
            const SizedBox(width: 12),
            Text(
              'Logout',
              style: GoogleFonts.playfairDisplay(
                color: const Color(0xFFFFD700),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Text(
          'Are you sure you want to logout?',
          style: GoogleFonts.montserrat(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              'Cancel',
              style: GoogleFonts.montserrat(color: Colors.white70),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFD700),
              foregroundColor: Colors.black,
            ),
            child: Text(
              'Logout',
              style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      await ApiService.logout();
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    }
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return AnimatedBuilder(
      animation: _cardAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _cardAnimation.value,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFFFFD700).withOpacity(0.1),
                  const Color(0xFFB8860B).withOpacity(0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFFFFD700).withOpacity(0.3),
              ),
            ),
            child: Column(
              children: [
                Icon(icon, color: const Color(0xFFFFD700), size: 24),
                const SizedBox(height: 8),
                Text(
                  value,
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFFFD700),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    color: Colors.white70,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBenefitItem(String benefit, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFFFD700).withOpacity(0.2),
            ),
            child: Icon(icon, color: const Color(0xFFFFD700), size: 14),
          ),
          const SizedBox(width: 12),
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
              'PROFILE',
              style: GoogleFonts.playfairDisplay(
                fontWeight: FontWeight.bold,
                color: const Color(0xFFFFD700),
                fontSize: 20,
              ),
            ),
            centerTitle: false,
            actions: [
              IconButton(
                icon: const Icon(Icons.logout, color: Color(0xFFFFD700)),
                onPressed: _logout,
              ),
              const SizedBox(width: 8),
            ],
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
                    child: AnimatedBuilder(
                      animation: _profileAnimation,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(0, 30 * (1 - _profileAnimation.value)),
                          child: Opacity(
                            opacity: _profileAnimation.value,
                            child: Row(
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
                                    Icons.person,
                                    size: 32,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'PLATINUM MEMBER',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 11,
                                          color: Colors.white70,
                                          letterSpacing: 2,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Premium access enabled',
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
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                
                AnimatedBuilder(
                  animation: _cardAnimation,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, 50 * (1 - _cardAnimation.value)),
                      child: Opacity(
                        opacity: _cardAnimation.value,
                        child: Container(
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
                                children: [
                                  Container(
                                    width: 70,
                                    height: 70,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: const RadialGradient(
                                        colors: [Color(0xFFFFD700), Color(0xFFB8860B)],
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFFFFD700).withOpacity(0.3),
                                          blurRadius: 15,
                                          spreadRadius: 2,
                                        ),
                                      ],
                                    ),
                                    child: const Icon(
                                      Icons.person,
                                      size: 36,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Demo User',
                                          style: GoogleFonts.playfairDisplay(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 4),
                                          decoration: BoxDecoration(
                                            gradient: const LinearGradient(
                                              colors: [Color(0xFFFFD700), Color(0xFFB8860B)],
                                            ),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const Icon(
                                                Icons.workspace_premium,
                                                size: 16,
                                                color: Colors.black,
                                              ),
                                              const SizedBox(width: 6),
                                              Text(
                                                'Platinum Member',
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 12,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          'Total Spent: \$25,000.00',
                                          style: GoogleFonts.montserrat(
                                            fontSize: 14,
                                            color: Colors.white70,
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
                    );
                  },
                ),
                
                const SizedBox(height: 24),
                
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard('Orders', '127', Icons.shopping_bag),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildStatCard('Saved', '\$3,750', Icons.savings),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildStatCard('Points', '12.5K', Icons.star),
                    ),
                  ],
                ),
                
                const SizedBox(height: 24),
                
                AnimatedBuilder(
                  animation: _cardAnimation,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, 30 * (1 - _cardAnimation.value)),
                      child: Opacity(
                        opacity: _cardAnimation.value,
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                const Color(0xFFFFD700).withOpacity(0.08),
                                const Color(0xFFB8860B).withOpacity(0.03),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: const Color(0xFFFFD700).withOpacity(0.2),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: const Color(0xFFFFD700).withOpacity(0.2),
                                    ),
                                    child: const Icon(
                                      Icons.workspace_premium,
                                      color: Color(0xFFFFD700),
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    'Platinum Benefits',
                                    style: GoogleFonts.playfairDisplay(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFFFFD700),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              
                              _buildBenefitItem('20% cashback on all purchases', Icons.account_balance_wallet),
                              _buildBenefitItem('Free shipping worldwide', Icons.local_shipping),
                              _buildBenefitItem('Priority support', Icons.headset_mic),
                              _buildBenefitItem('Exclusive products access', Icons.diamond),
                              _buildBenefitItem('Personal shopper service', Icons.person_pin),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                
                const SizedBox(height: 24),
                
                AnimatedBuilder(
                  animation: _cardAnimation,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, 20 * (1 - _cardAnimation.value)),
                      child: Opacity(
                        opacity: _cardAnimation.value,
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                const Color(0xFFFFD700).withOpacity(0.05),
                                const Color(0xFFB8860B).withOpacity(0.02),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: const Color(0xFFFFD700).withOpacity(0.2),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: const Color(0xFFFFD700).withOpacity(0.2),
                                    ),
                                    child: const Icon(
                                      Icons.smart_toy,
                                      color: Color(0xFFFFD700),
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    'AI Concierge',
                                    style: GoogleFonts.playfairDisplay(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFFFFD700),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              
                              if (_aiResponse.isNotEmpty) ...[
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFD700).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    _aiResponse,
                                    style: GoogleFonts.montserrat(
                                      color: Colors.white,
                                      fontSize: 14,
                                      height: 1.5,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                              ],
                              
                              Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: _chatController,
                                      style: GoogleFonts.montserrat(color: Colors.white),
                                      decoration: InputDecoration(
                                        hintText: 'Ask your AI concierge anything...',
                                        hintStyle: GoogleFonts.montserrat(
                                          color: Colors.white54,
                                        ),
                                        filled: true,
                                        fillColor: Colors.white.withOpacity(0.05),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                          borderSide: BorderSide(
                                            color: const Color(0xFFFFD700).withOpacity(0.3),
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                          borderSide: BorderSide(
                                            color: const Color(0xFFFFD700).withOpacity(0.3),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                          borderSide: const BorderSide(
                                            color: Color(0xFFFFD700),
                                          ),
                                        ),
                                        contentPadding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 12),
                                      ),
                                      onSubmitted: _sendAIMessage,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Container(
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [Color(0xFFFFD700), Color(0xFFB8860B)],
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: IconButton(
                                      onPressed: _isLoadingAI 
                                          ? null 
                                          : () => _sendAIMessage(_chatController.text),
                                      icon: _isLoadingAI
                                          ? const SizedBox(
                                              width: 20,
                                              height: 20,
                                              child: CircularProgressIndicator(
                                                color: Colors.black,
                                                strokeWidth: 2,
                                              ),
                                            )
                                          : const Icon(
                                              Icons.send,
                                              color: Colors.black,
                                            ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                
                const SizedBox(height: 32),
                
              ]),
            ),
          ),
        ],
      ),
    );
  }
}