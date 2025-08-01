import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../services/api_service.dart';
import '../../models/product.dart';
import '../../widgets/product_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  List<Product> _searchResults = [];
  bool _isLoading = false;
  bool _hasSearched = false;
  String _aiMessage = '';
  Map<String, dynamic> _aiInsights = {};
  String _userTier = 'bronze';

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadUserInfo() async {
    try {
      final userInfo = await ApiService.getCurrentUser();
      if (mounted) {
        setState(() {
          _userTier = userInfo['vip_tier'] ?? 'bronze';
        });
      }
    } catch (e) {
      debugPrint('Error loading user info: $e');
    }
  }

  Future<void> _performSearch() async {
    final query = _searchController.text.trim();
    if (query.isEmpty) return;

    setState(() {
      _isLoading = true;
      _hasSearched = false;
    });

    final result = await ApiService.aiSearch(query);

    setState(() {
      _isLoading = false;
      _hasSearched = true;
      
      if (result['success']) {
        // Apply tier-based search result limits
        final products = result['products'] as List<Product>;
        final int resultLimit = _getSearchResultLimit();
        _searchResults = products.take(resultLimit).toList();
        _aiMessage = result['message'];
        _aiInsights = result['insights'];
      } else {
        _searchResults = [];
        _aiMessage = result['message'];
        _aiInsights = {};
      }
    });
  }

  int _getSearchResultLimit() {
    // VIP users get 24 search results, regular users get 12
    return ['gold', 'platinum'].contains(_userTier) ? 24 : 12;
  }

  String _getSearchLimitText() {
    final limit = _getSearchResultLimit();
    final tierText = ['gold', 'platinum'].contains(_userTier) ? 'VIP' : 'Regular';
    return 'Showing up to $limit results for $tierText members';
  }

  Widget _buildSuggestionChip(String suggestion) {
    return GestureDetector(
      onTap: () {
        _searchController.text = suggestion;
        _performSearch();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFFFFD700).withOpacity(0.3),
          ),
        ),
        child: Text(
          suggestion,
          style: GoogleFonts.montserrat(
            color: const Color(0xFFFFD700),
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'AI Search',
          style: GoogleFonts.playfairDisplay(
            fontWeight: FontWeight.bold,
            color: const Color(0xFFFFD700),
          ),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Color(0xFFFFD700)),
      ),
      body: Column(
        children: [
          // Search Header
          Container(
            padding: const EdgeInsets.all(16),
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
            child: Column(
              children: [
                // Search Bar
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1A1A),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFFFFD700).withOpacity(0.3),
                    ),
                  ),
                  child: TextField(
                    controller: _searchController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Search with natural language... 🤖',
                      hintStyle: GoogleFonts.montserrat(
                        color: Colors.white54,
                        fontSize: 14,
                      ),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Color(0xFFFFD700),
                        size: 20,
                      ),
                      suffixIcon: _isLoading
                          ? const Padding(
                              padding: EdgeInsets.all(12),
                              child: SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Color(0xFFFFD700),
                                ),
                              ),
                            )
                          : IconButton(
                              icon: const Icon(
                                Icons.send,
                                color: Color(0xFFFFD700),
                                size: 20,
                              ),
                              onPressed: _performSearch,
                            ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    onSubmitted: (_) => _performSearch(),
                  ),
                ),
                
                const SizedBox(height: 12),
                
                // Tier info
                Text(
                  _getSearchLimitText(),
                  style: GoogleFonts.montserrat(
                    color: const Color(0xFFFFD700),
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                
                const SizedBox(height: 12),
                
                // Search Suggestions
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildSuggestionChip('luxury watch'),
                      const SizedBox(width: 6),
                      _buildSuggestionChip('designer bag'),
                      const SizedBox(width: 6),
                      _buildSuggestionChip('premium tech'),
                      const SizedBox(width: 6),
                      _buildSuggestionChip('jewelry'),
                      const SizedBox(width: 6),
                      _buildSuggestionChip('rolex'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Results
          Expanded(
            child: _buildSearchResults(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    if (!_hasSearched && !_isLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFFFFD700).withOpacity(0.3),
                    const Color(0xFFFFD700).withOpacity(0.1),
                  ],
                ),
              ),
              child: const Icon(
                Icons.psychology,
                size: 40,
                color: Color(0xFFFFD700),
              ),
            ),
            
            const SizedBox(height: 20),
            
            Text(
              'AI-Powered Search',
              style: GoogleFonts.playfairDisplay(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color(0xFFFFD700),
              ),
            ),
            
            const SizedBox(height: 8),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'Search using natural language.\nTry "expensive watches" or "luxury bags"',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  color: Colors.white70,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      );
    }

    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: Color(0xFFFFD700),
        ),
      );
    }

    if (_searchResults.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: Colors.white.withOpacity(0.3),
            ),
            const SizedBox(height: 16),
            Text(
              'No products found',
              style: GoogleFonts.playfairDisplay(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _aiMessage.isNotEmpty ? _aiMessage : 'Try different search terms',
              style: GoogleFonts.montserrat(
                fontSize: 14,
                color: Colors.white70,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        // AI Message
        if (_aiMessage.isNotEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            color: const Color(0xFF1A1A1A),
            child: Text(
              _aiMessage,
              style: GoogleFonts.montserrat(
                fontSize: 12,
                color: const Color(0xFFFFD700),
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        
        // Results Grid
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.7,
            ),
            itemCount: _searchResults.length,
            itemBuilder: (context, index) {
              final product = _searchResults[index];
              return ProductCard(product: product);
            },
          ),
        ),
        
        // AI Insights
        if (_aiInsights.isNotEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            color: const Color(0xFF1A1A1A),
            child: Column(
              children: [
                Text(
                  '🤖 Search Insights',
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFFFD700),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Found ${_aiInsights['results_found'] ?? 0} results using ${_aiInsights['search_type'] ?? 'AI processing'}',
                  style: GoogleFonts.montserrat(
                    fontSize: 10,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}