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

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
        _searchResults = result['products'];
        _aiMessage = result['message'];
        _aiInsights = result['insights'];
      } else {
        _searchResults = [];
        _aiMessage = result['message'];
        _aiInsights = {};
      }
    });
  }

  Widget _buildSuggestionChip(String suggestion) {
    return GestureDetector(
      onTap: () {
        _searchController.text = suggestion;
        _performSearch();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFFFFD700).withOpacity(0.3),
          ),
        ),
        child: Text(
          suggestion,
          style: GoogleFonts.montserrat(
            color: const Color(0xFFFFD700),
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'AI Search',
          style: GoogleFonts.playfairDisplay(
            fontWeight: FontWeight.bold,
            color: const Color(0xFFFFD700),
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          // Search Header
          Container(
            padding: const EdgeInsets.all(20),
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
                    borderRadius: BorderRadius.circular(25),
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
                      ),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Color(0xFFFFD700),
                      ),
                      suffixIcon: _isLoading
                          ? const Padding(
                              padding: EdgeInsets.all(12),
                              child: SizedBox(
                                width: 20,
                                height: 20,
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
                              ),
                              onPressed: _performSearch,
                            ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                    ),
                    onSubmitted: (_) => _performSearch(),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Search Suggestions
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildSuggestionChip('luxury watch'),
                      const SizedBox(width: 8),
                      _buildSuggestionChip('designer handbag'),
                      const SizedBox(width: 8),
                      _buildSuggestionChip('premium electronics'),
                      const SizedBox(width: 8),
                      _buildSuggestionChip('expensive car'),
                      const SizedBox(width: 8),
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
              width: 100,
              height: 100,
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
                size: 50,
                color: Color(0xFFFFD700),
              ),
            ),
            
            const SizedBox(height: 24),
            
            Text(
              'AI-Powered Search',
              style: GoogleFonts.playfairDisplay(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: const Color(0xFFFFD700),
              ),
            ),
            
            const SizedBox(height: 12),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'Search using natural language. Try "luxury watch" or "expensive handbag"',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  color: Colors.white70,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      );
    }

    if (_searchResults.isEmpty && _hasSearched) {
      return Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.search_off,
              size: 64,
              color: Colors.white54,
            ),
            
            const SizedBox(height: 16),
            
            Text(
              'No Products Found',
              style: GoogleFonts.playfairDisplay(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            
            const SizedBox(height: 8),
            
            if (_aiMessage.isNotEmpty)
              Text(
                _aiMessage,
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  color: Colors.white70,
                ),
                textAlign: TextAlign.center,
              ),
            
            if (_aiInsights.isNotEmpty) ...[
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A1A),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFFFFD700).withOpacity(0.3),
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      '🤖 AI Suggestion',
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFFFD700),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _aiInsights['suggestion'] ?? '',
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
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
            padding: const EdgeInsets.all(16),
            color: const Color(0xFF1A1A1A),
            child: Text(
              _aiMessage,
              style: GoogleFonts.montserrat(
                fontSize: 14,
                color: const Color(0xFFFFD700),
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        
        // Results Grid
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.75,
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
            padding: const EdgeInsets.all(16),
            color: const Color(0xFF1A1A1A),
            child: Column(
              children: [
                Text(
                  '🤖 Search Insights',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFFFD700),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Found ${_aiInsights['results_found']} results using ${_aiInsights['search_type']}',
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
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