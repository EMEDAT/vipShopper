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
          // CRITICAL FIX: Create User object from flat API response
          _currentUser = User.fromApiResponse({
            'id': result['id'],
            'name': result['name'],
            'email': result['email'],
            'vip_tier': result['vip_tier'],
            'total_spent': result['total_spent'],
            'preferences': result['preferences'],
          });
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

  Color get _tierColor {
    switch (_currentUser?.vipTier) {
      case 'platinum':
        return const Color(0xFFE5E4E2); // Platinum silver
      case 'gold':
        return const Color(0xFFFFD700);
      case 'silver':
        return const Color(0xFFC0C0C0);
      case 'bronze':
      default:
        return const Color(0xFFCD7F32);
    }
  }

  List<String> get _currentBenefits {
    return (_vipStatus?['benefits'] as List<dynamic>?)
        ?.map((benefit) => benefit.toString())
        .toList() ?? ['Basic membership benefits'];
  }

  Map<String, String> get _userStats {
    final totalSpent = _currentUser?.totalSpent ?? 0;
    final tier = _currentUser?.vipTier ?? 'bronze';
    final preferences = _currentUser?.preferences.length ?? 0;
    
    return {
      'Total Spent': '\$${totalSpent.toStringAsFixed(2)}',
      'Current Tier': tier.toUpperCase(),
      'Preferences': '$preferences set',
      'Member Since': '2024', // You can calculate this from created_at if available
    };
  }

  Future<void> _logout() async {
    final success = await ApiService.logout();
    if (mounted) {
      if (success) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Logout failed. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _sendAIMessage() async {
    final message = _chatController.text.trim();
    if (message.isEmpty) return;

    setState(() {
      _isLoadingAI = true;
      _aiResponse = '';
    });

    _chatController.clear();

    final result = await ApiService.aiChat(message);

    if (mounted) {
      setState(() {
        _isLoadingAI = false;
        _aiResponse = result['success'] ? result['response'] : result['message'];
      });
    }
  }

  Widget _buildStatCard(String label, String value, IconData icon) {
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
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: _tierColor.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(icon, color: _tierColor, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.playfairDisplay(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            label,
            style: GoogleFonts.montserrat(
              fontSize: 12,
              color: Colors.white70,
            ),
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

  // 🔥 NEW: Bio section with locked UI for regular users
  Widget _buildBioSection() {
    final isVipUser = _currentUser?.canAccessVipProducts ?? false;
    
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
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
          color: isVipUser 
            ? _tierColor.withOpacity(0.3)
            : Colors.grey.withOpacity(0.3),
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                isVipUser ? Icons.person : Icons.lock_outline,
                color: isVipUser ? _tierColor : Colors.grey,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                'Profile Bio',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              if (!isVipUser) ...[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.red, width: 1),
                  ),
                  child: Text(
                    'LOCKED',
                    style: GoogleFonts.montserrat(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 16),
          
          if (isVipUser) ...[
            // UNLOCKED: Show full bio for VIP users
            Text(
              _currentUser?.name != null 
                ? "Welcome ${_currentUser!.name}! As a ${_currentUser!.vipTier.toUpperCase()} member, you have exclusive access to premium features and personalized recommendations."
                : "VIP member profile unlocked!",
              style: GoogleFonts.montserrat(
                fontSize: 14,
                color: Colors.white,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "Your preferences: ${_currentUser?.preferences.join(', ') ?? 'Not set'}",
              style: GoogleFonts.montserrat(
                fontSize: 12,
                color: Colors.white70,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _tierColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _tierColor.withOpacity(0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.verified,
                    color: _tierColor,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'VIP Benefits Active',
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: _tierColor,
                    ),
                  ),
                ],
              ),
            ),
          ] else ...[
            // LOCKED: Show restricted content for regular users
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.grey.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.lock_outline,
                    size: 32,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Premium Bio Content',
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Upgrade to Gold or Platinum to unlock personalized bio content, preference settings, and advanced profile features.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      color: Colors.grey.shade400,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFFFFD700).withOpacity(0.3),
                          const Color(0xFFFFD700).withOpacity(0.1),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color(0xFFFFD700).withOpacity(0.5),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      'UPGRADE TO UNLOCK',
                      style: GoogleFonts.montserrat(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFFFD700),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  // 🔥 NEW: Shopping restrictions section for regular users
  Widget _buildShoppingRestrictionsSection() {
    final isVipUser = _currentUser?.canAccessVipProducts ?? false;
    
    if (isVipUser) return const SizedBox.shrink(); // Don't show for VIP users
    
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.red.withOpacity(0.1),
            Colors.red.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.red.withOpacity(0.3),
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.shopping_cart_outlined,
                color: Colors.red,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                'Shopping Access',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.red, width: 1),
                ),
                child: Text(
                  'LIMITED',
                  style: GoogleFonts.montserrat(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.red.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Current Restrictions:',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                _buildRestrictionItem('🔒 No access to VIP exclusive products'),
                _buildRestrictionItem('🔒 Limited to 15 products per page'),
                _buildRestrictionItem('🔒 Standard search results only'),
                _buildRestrictionItem('🔒 Basic cashback rates (5%)'),
                _buildRestrictionItem('🔒 Limited customer support priority'),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFFFFD700).withOpacity(0.2),
                        const Color(0xFFFFD700).withOpacity(0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '✨ Upgrade Benefits:',
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          color: const Color(0xFFFFD700),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Gold: 15% cashback + VIP products\nPlatinum: 20% cashback + personal shopper',
                        style: GoogleFonts.montserrat(
                          fontSize: 11,
                          color: Colors.white70,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRestrictionItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        text,
        style: GoogleFonts.montserrat(
          fontSize: 12,
          color: Colors.red.shade300,
        ),
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

    final stats = _userStats;

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
                fontSize: ResponsiveGrid.getTitleFontSize(context),
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
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
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
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  _tierDisplayName,
                                  style: GoogleFonts.playfairDisplay(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: _tierColor,
                                    height: 1.1,
                                  ),
                                ),
                                Text(
                                  _tierSubtitle,
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
                    ),
                  ),
                ),
              ),
            ),
          ),

          // User Profile Card
          SliverToBoxAdapter(
            child: AnimatedBuilder(
              animation: _cardAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: 0.8 + (0.2 * _cardAnimation.value),
                  child: Opacity(
                    opacity: _cardAnimation.value,
                    child: Container(
                      margin: const EdgeInsets.all(16),
                      padding: const EdgeInsets.all(20),
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
                                      _currentUser?.name ?? 'Unknown User',
                                      style: GoogleFonts.playfairDisplay(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      _currentUser?.email ?? 'No email',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 14,
                                        color: Colors.white70,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [_tierColor, _tierColor.withOpacity(0.8)],
                                        ),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Text(
                                        _tierDisplayName,
                                        style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          
                          // Stats Grid
                          GridView.count(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: 2,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            childAspectRatio: 1.2,
                            children: [
                              _buildStatCard(
                                'Total Spent',
                                stats['Total Spent']!,
                                Icons.attach_money,
                              ),
                              _buildStatCard(
                                'Current Tier',
                                stats['Current Tier']!,
                                Icons.star,
                              ),
                              _buildStatCard(
                                'Preferences',
                                stats['Preferences']!,
                                Icons.favorite,
                              ),
                              _buildStatCard(
                                'Member Since',
                                stats['Member Since']!,
                                Icons.calendar_today,
                              ),
                            ],
                          ),
                          
                          const SizedBox(height: 20),
                          
                          // Benefits Section
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: _tierColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: _tierColor.withOpacity(0.3),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Your Benefits',
                                  style: GoogleFonts.playfairDisplay(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                ..._currentBenefits
                                    .map((benefit) => _buildBenefitItem(
                                          benefit,
                                          Icons.check_circle,
                                        ))
                                    .toList(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // 🔥 NEW: Bio Section with locked UI
          SliverToBoxAdapter(child: _buildBioSection()),

          // 🔥 NEW: Shopping Restrictions Section (only for regular users)
          SliverToBoxAdapter(child: _buildShoppingRestrictionsSection()),

          // AI Chat Section
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
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
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.smart_toy,
                        color: Color(0xFFFFD700),
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'AI Assistant',
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // AI Response
                  if (_aiResponse.isNotEmpty)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFD700).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFFFFD700).withOpacity(0.3),
                        ),
                      ),
                      child: Text(
                        _aiResponse,
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          color: Colors.white,
                          height: 1.5,
                        ),
                      ),
                    ),
                  
                  // Input Section
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _chatController,
                          style: GoogleFonts.montserrat(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Ask me about products or recommendations...',
                            hintStyle: GoogleFonts.montserrat(color: Colors.white54),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.1),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                          onSubmitted: (_) => _sendAIMessage(),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          onPressed: _isLoadingAI ? null : _sendAIMessage,
                          icon: _isLoadingAI
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.black,
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

          // Bottom padding
          const SliverToBoxAdapter(
            child: SizedBox(height: 100),
          ),
        ],
      ),
    );
  }
}