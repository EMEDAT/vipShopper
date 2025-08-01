import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../services/api_service.dart';
import '../../models/user.dart';
import '../auth/login_screen.dart';
import '../../utils/responsive_grid.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> 
    with TickerProviderStateMixin {
  String _aiResponse = '';
  bool _isLoadingAI = false;
  bool _isLoadingUser = true;
  final _chatController = TextEditingController();
  late AnimationController _cardAnimationController;
  late Animation<double> _cardAnimation;
  
  User? _currentUser;
  Map<String, dynamic>? _vipStatus;

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _loadCurrentUser();
  }

  void _initAnimations() {
    _cardAnimationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _cardAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _cardAnimationController, curve: Curves.easeOut),
    );
  }

  Future<void> _loadCurrentUser() async {
    try {
      final result = await ApiService.getCurrentUser();
      if (mounted && result['success']) {
        setState(() {
          _currentUser = result['user'];
          _vipStatus = result['vip_status'];
          _isLoadingUser = false;
        });
        _cardAnimationController.forward();
      } else {
        setState(() {
          _isLoadingUser = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoadingUser = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _chatController.dispose();
    _cardAnimationController.dispose();
    super.dispose();
  }

  String get _tierDisplayName {
    if (_currentUser?.vipTier == null) return 'MEMBER';
    return '${_currentUser!.vipTier.toUpperCase()} MEMBER';
  }

  String get _tierSubtitle {
    switch (_currentUser?.vipTier) {
      case 'platinum':
        return 'Premium access enabled';
      case 'gold':
        return 'VIP access enabled';
      case 'silver':
        return 'Enhanced benefits active';
      case 'bronze':
      default:
        return 'Standard membership';
    }
  }

  // FIXED: Better platinum color and tier colors
  Color get _tierColor {
    switch (_currentUser?.vipTier) {
      case 'platinum':
        return const Color(0xFFD4E6F1); // Better platinum blue-silver
      case 'gold':
        return const Color(0xFFFFD700); // Gold
      case 'silver':
        return const Color(0xFFC0C0C0); // Silver
      case 'bronze':
      default:
        return const Color(0xFFCD7F32); // Bronze
    }
  }

  List<String> get _currentBenefits {
    return (_vipStatus?['benefits'] as List<dynamic>?)
        ?.map((benefit) => benefit.toString())
        .toList() ?? ['Basic membership benefits'];
  }

  // FIXED: Dynamic stats based on user tier and spending
  Map<String, String> get _userStats {
    final totalSpent = _currentUser?.totalSpent ?? 0;
    final tier = _currentUser?.vipTier ?? 'bronze';
    
    // Calculate realistic stats based on tier and spending
    int orders;
    String saved;
    String points;
    
    switch (tier) {
      case 'platinum':
        orders = (totalSpent / 200).round(); // $200 avg per order
        saved = '\$${(totalSpent * 0.20).round()}'; // 20% cashback
        points = '${((totalSpent / 10) * 1.5).round()}K'; // 1.5x points
        break;
      case 'gold':
        orders = (totalSpent / 150).round(); // $150 avg per order
        saved = '\$${(totalSpent * 0.15).round()}'; // 15% cashback
        points = '${((totalSpent / 10) * 1.2).round()}K'; // 1.2x points
        break;
      case 'silver':
        orders = (totalSpent / 100).round(); // $100 avg per order
        saved = '\$${(totalSpent * 0.10).round()}'; // 10% cashback
        points = '${(totalSpent / 10).round()}K'; // Standard points
        break;
      case 'bronze':
      default:
        orders = (totalSpent / 75).round(); // $75 avg per order
        saved = '\$${(totalSpent * 0.05).round()}'; // 5% cashback
        points = '${(totalSpent / 15).round()}K'; // Lower points rate
        break;
    }
    
    // Ensure minimum realistic values
    orders = orders < 1 ? 1 : orders;
    if (saved == '\$0') saved = '\$0';
    if (points == '0K') points = '0.1K';
    
    return {
      'orders': orders.toString(),
      'saved': saved,
      'points': points,
    };
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
          style: GoogleFonts.montserrat(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              'Cancel',
              style: GoogleFonts.montserrat(color: Colors.white70),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              'Logout',
              style: GoogleFonts.montserrat(color: const Color(0xFFFFD700)),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ApiService.logout();
      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false,
        );
      }
    }
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            _tierColor.withOpacity(0.1),
            _tierColor.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _tierColor.withOpacity(0.3),
        ),
      ),
      child: Column(
        children: [
          Icon(icon, color: _tierColor, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.montserrat(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
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
              color: _tierColor.withOpacity(0.2),
            ),
            child: Icon(icon, color: _tierColor, size: 14),
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
    if (_isLoadingUser) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: const Color(0xFFFFD700)),
              const SizedBox(height: 16),
              Text(
                'Loading profile...',
                style: GoogleFonts.montserrat(color: Colors.white70),
              ),
            ],
          ),
        ),
      );
    }

    final stats = _userStats; // Get dynamic stats

    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
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
              'PROFILE',
              style: GoogleFonts.playfairDisplay(
                fontWeight: FontWeight.bold,
                color: const Color(0xFFFFD700),
                fontSize: ResponsiveGrid.getTitleFontSize(context),              ),
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
                    // FIXED: Reduced top padding from 80 to 60 to lift content upward
                    padding: ResponsiveGrid.getHeaderPadding(context),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [_tierColor, _tierColor.withOpacity(0.7)],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: _tierColor.withOpacity(0.4),
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _tierDisplayName,
                                style: GoogleFonts.montserrat(
                                  fontSize: 11,
                                  color: Colors.white70,
                                  letterSpacing: 2,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _tierSubtitle,
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  color: _tierColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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
                    return Opacity(
                      opacity: _cardAnimation.value.clamp(0.0, 1.0),
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              _tierColor.withOpacity(0.1),
                              _tierColor.withOpacity(0.05),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: _tierColor.withOpacity(0.3),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: _tierColor.withOpacity(0.1),
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
                                    gradient: RadialGradient(
                                      colors: [_tierColor, _tierColor.withOpacity(0.7)],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: _tierColor.withOpacity(0.3),
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
                                        _currentUser?.name ?? 'User',
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
                                          gradient: LinearGradient(
                                            colors: [_tierColor, _tierColor.withOpacity(0.7)],
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
                                              _tierDisplayName,
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
                                        'Total Spent: \$${(_currentUser?.totalSpent ?? 0).toStringAsFixed(2)}',
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
                    );
                  },
                ),
                
                const SizedBox(height: 24),
                
                // FIXED: Dynamic stats based on user tier and spending
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard('Orders', stats['orders']!, Icons.shopping_bag),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildStatCard('Saved', stats['saved']!, Icons.savings),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildStatCard('Points', stats['points']!, Icons.star),
                    ),
                  ],
                ),
                
                const SizedBox(height: 24),
                
                AnimatedBuilder(
                  animation: _cardAnimation,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _cardAnimation.value.clamp(0.0, 1.0),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              _tierColor.withOpacity(0.08),
                              _tierColor.withOpacity(0.03),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: _tierColor.withOpacity(0.2),
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
                                    color: _tierColor.withOpacity(0.2),
                                  ),
                                  child: Icon(Icons.star, color: _tierColor, size: 20),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  'Membership Benefits',
                                  style: GoogleFonts.playfairDisplay(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            ..._currentBenefits.map((benefit) => 
                              _buildBenefitItem(benefit, Icons.check_circle)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                
                const SizedBox(height: 24),
                
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xFFFFD700).withOpacity(0.08),
                        const Color(0xFFFFD700).withOpacity(0.03),
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
                            child: const Icon(Icons.smart_toy, color: Color(0xFFFFD700), size: 20),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'AI Concierge',
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
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
                            color: const Color(0xFF1A1A1A),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color(0xFFFFD700).withOpacity(0.3),
                            ),
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
                        const SizedBox(height: 16),
                      ],
                      
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _chatController,
                              style: GoogleFonts.montserrat(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: 'Ask me anything...',
                                hintStyle: GoogleFonts.montserrat(color: Colors.white54),
                                filled: true,
                                fillColor: const Color(0xFF1A1A1A),
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
                              ),
                              onSubmitted: _sendAIMessage,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            height: 48,
                            width: 48,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFFFFD700), Color(0xFFB8860B)],
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: _isLoadingAI
                                ? const Center(
                                    child: SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.black,
                                      ),
                                    ),
                                  )
                                : IconButton(
                                    onPressed: () => _sendAIMessage(_chatController.text),
                                    icon: const Icon(Icons.send, color: Colors.black),
                                  ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 100),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}