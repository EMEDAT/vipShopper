import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../services/api_service.dart';
import '../auth/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _aiResponse = '';
  bool _isLoadingAI = false;
  final _chatController = TextEditingController();

  @override
  void dispose() {
    _chatController.dispose();
    super.dispose();
  }

  Future<void> _sendAIMessage(String message) async {
    if (message.trim().isEmpty) return;

    setState(() {
      _isLoadingAI = true;
    });

    final result = await ApiService.aiChat(message);

    setState(() {
      _isLoadingAI = false;
      if (result['success']) {
        _aiResponse = result['response'];
      } else {
        _aiResponse = 'AI concierge is temporarily unavailable.';
      }
    });

    _chatController.clear();
  }

  Future<void> _logout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        title: const Text(
          'Logout',
          style: TextStyle(color: Color(0xFFFFD700)),
        ),
        content: const Text(
          'Are you sure you want to logout?',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel', style: TextStyle(color: Colors.white70)),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Logout', style: TextStyle(color: Color(0xFFFFD700))),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ApiService.logout();
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
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
                'PROFILE',
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
                          Icons.person,
                          size: 40,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: _logout,
              ),
            ],
          ),
          
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // User Demo Info
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
                      Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: const RadialGradient(
                                colors: [
                                  Color(0xFFFFD700),
                                  Color(0xFFB8860B),
                                ],
                              ),
                            ),
                            child: const Icon(
                              Icons.person,
                              size: 30,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Demo User',
                                  style: GoogleFonts.playfairDisplay(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Text(
                                      '👑',
                                      style: GoogleFonts.montserrat(fontSize: 16),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Platinum Member',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 14,
                                        color: const Color(0xFFFFD700),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Total Spent: \$25,000.00',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // VIP Benefits
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '👑 Platinum Benefits',
                              style: GoogleFonts.montserrat(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFFFFD700),
                              ),
                            ),
                            const SizedBox(height: 12),
                            _buildBenefitRow('20% cashback on all purchases'),
                            _buildBenefitRow('Free shipping worldwide'),
                            _buildBenefitRow('Priority support'),
                            _buildBenefitRow('Exclusive products access'),
                            _buildBenefitRow('Personal shopper service'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 30),
                
                // AI Concierge Chat
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1A1A),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFFFFD700).withOpacity(0.3),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: const RadialGradient(
                                colors: [
                                  Color(0xFFFFD700),
                                  Color(0xFFB8860B),
                                ],
                              ),
                            ),
                            child: const Icon(
                              Icons.psychology,
                              size: 24,
                              color: Colors.black,
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
                      
                      Text(
                        'Ask me about VIP benefits, upgrades, or product recommendations!',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Chat Input
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _chatController,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: 'Ask your AI concierge...',
                                hintStyle: GoogleFonts.montserrat(
                                  color: Colors.white54,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide(
                                    color: const Color(0xFFFFD700).withOpacity(0.3),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide(
                                    color: const Color(0xFFFFD700).withOpacity(0.3),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: const BorderSide(
                                    color: Color(0xFFFFD700),
                                    width: 2,
                                  ),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                              ),
                              onSubmitted: _sendAIMessage,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: const RadialGradient(
                                colors: [
                                  Color(0xFFFFD700),
                                  Color(0xFFB8860B),
                                ],
                              ),
                            ),
                            child: IconButton(
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
                              onPressed: _isLoadingAI
                                  ? null
                                  : () => _sendAIMessage(_chatController.text),
                            ),
                          ),
                        ],
                      ),
                      
                      // Quick Chat Buttons
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _buildQuickChatButton('Tell me about my VIP benefits'),
                          _buildQuickChatButton('How can I upgrade my tier?'),
                          _buildQuickChatButton('Recommend luxury products'),
                        ],
                      ),
                      
                      // AI Response
                      if (_aiResponse.isNotEmpty) ...[
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.psychology,
                                    size: 16,
                                    color: Color(0xFFFFD700),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'AI Concierge:',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFFFFD700),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                _aiResponse,
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  color: Colors.white,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                
                const SizedBox(height: 20),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBenefitRow(String benefit) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle,
            color: Color(0xFFFFD700),
            size: 16,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              benefit,
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickChatButton(String message) {
    return GestureDetector(
      onTap: () => _sendAIMessage(message),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFFFFD700).withOpacity(0.5),
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          message,
          style: GoogleFonts.montserrat(
            fontSize: 11,
            color: const Color(0xFFFFD700),
          ),
        ),
      ),
    );
  }
}