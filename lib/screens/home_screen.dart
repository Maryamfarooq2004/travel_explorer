import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/destination.dart';
import '../services/database_service.dart';
import '../services/recommendation_service.dart';
import '../widgets/swipeable_card_stack.dart';
import '../widgets/destination_card.dart';
import '../widgets/custom_floating_nav_bar.dart';
import '../widgets/category_chips.dart';
import '../widgets/service_quick_grid.dart';
import '../utils/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final RecommendationService _recommendationService = RecommendationService();
  final DatabaseService _dbService = DatabaseService();
  late Stream<List<Destination>> _destinationsStream;
  bool _isRecommendationReady = false;
  
  // State for UI
  String _selectedCategory = 'All';
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  int _currentNavIndex = 0;

  final List<String> _categories = [
    'All',
    'Mountains',
    'Beaches',
    'Lakes',
    'Historical',
    'City',
    'Nature'
  ];

  @override
  void initState() {
    super.initState();
    _destinationsStream = _dbService.getDestinations();
    _initRecommendation();
    _searchController.addListener(_onSearchChanged);
  }


  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text.toLowerCase();
    });
  }

  Future<void> _initRecommendation() async {
    await _recommendationService.init();
    if (mounted) {
      setState(() {
        _isRecommendationReady = true;
      });
    }
  }

  void _onCategorySelected(String category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  void _onDestinationTap(Destination destination) {
    Navigator.pushNamed(
      context, 
      '/details',
      arguments: destination,
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final userName = user?.displayName?.split(' ').first ?? 'Traveler';

    return Scaffold(
      backgroundColor: AppTheme.scaffoldBackgroundColor,
      // Stack needed for floating navbar
      body: Stack(
        children: [
          // 0. Jazz Gradient Background (Top Section)
          Container(
            height: 320, // Covers Header + Search
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppTheme.primaryColor,
                  AppTheme.primaryColor.withOpacity(0.0), // Fade to transparent
                ],
              ),
            ),
          ),

          // 1. Main Content
          StreamBuilder<List<Destination>>(
            stream: _destinationsStream,
            builder: (context, snapshotDestinations) {
          if (snapshotDestinations.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshotDestinations.hasError) {
            return Center(child: Text('Error: ${snapshotDestinations.error}'));
          }

          final allDestinations = snapshotDestinations.data ?? [];
          
          // Filter logic
          final filteredDestinations = allDestinations.where((d) {
             // 1. Category Filter
             final matchesCategory = _selectedCategory == 'All' || 
                                   d.category == _selectedCategory || 
                                   d.tags.contains(_selectedCategory.toLowerCase());
             
             // 2. Search Filter
             final matchesSearch = _searchQuery.isEmpty ||
                 d.name.toLowerCase().contains(_searchQuery) ||
                 d.location.toLowerCase().contains(_searchQuery) ||
                 d.tags.any((tag) => tag.toLowerCase().contains(_searchQuery));

             return matchesCategory && matchesSearch;
           }).toList();

          // Carousel Data
          final carouselDestinations = (allDestinations.toList()..shuffle()).take(5).toList();

          return StreamBuilder<List<String>>(
            stream: user != null ? _dbService.getFavoriteIds(user.uid) : Stream.value([]),
            builder: (context, snapshotFavorites) {
              final favoriteIds = snapshotFavorites.data ?? [];
              
              // Calculate Recommendations
              List<Destination> recommendations = [];
              if (_isRecommendationReady && favoriteIds.isNotEmpty && allDestinations.isNotEmpty) {
                final favoriteDestinations = allDestinations.where((d) => favoriteIds.contains(d.id)).toList();
                recommendations = _recommendationService.recommend(allDestinations, favoriteDestinations).take(5).toList();
              }

              // Determine Main Highlight (Recommendations > Top Picks)
              final highlightList = recommendations.isNotEmpty ? recommendations : carouselDestinations;
              final highlightTitle = recommendations.isNotEmpty ? "Recommended" : "Featured Destinations";

              return CustomScrollView(
                slivers: [
                  // 1. Modern SliverAppBar
                  SliverAppBar(
                    expandedHeight: 70.0, // Much more compact
                    pinned: true,
                    backgroundColor: Colors.transparent, // Transparent for gradient
                    surfaceTintColor: Colors.transparent,
                    elevation: 0,
                    flexibleSpace: FlexibleSpaceBar(
                      titlePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      centerTitle: false,
                      title: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Travel',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                                letterSpacing: 0.5,
                              ),
                            ),
                            TextSpan(
                              text: 'Mate',
                              style: GoogleFonts.playfairDisplay(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                fontSize: 22, // Slightly larger for flair
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.only(right: 24),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.grey[200],
                          backgroundImage: user?.photoURL != null 
                              ? NetworkImage(user!.photoURL!) 
                              : null,
                          child: user?.photoURL == null 
                              ? const Icon(Icons.person, color: Colors.grey) 
                              : null,
                        ),
                      ),
                    ],
                  ),

                  // 2. Greeting & Search (Non-sticky Header content)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20), // Tighter slide padding
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome back, $userName \u{1F44B}",
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 14, 
                              color: Colors.white.withOpacity(0.9), // Light text
                            ),
                          ),
                          const SizedBox(height: 16), // Reduced gap
                          Container(
                            height: 30, // More compact
                            decoration: BoxDecoration(
                              // Super round pill
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.04),
                                  blurRadius: 16,
                                  spreadRadius: 4,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: TextField(

                              controller: _searchController,
                              style: const TextStyle(fontSize: 14),
                              onChanged: (value) {},
                              decoration: InputDecoration(
                                hintText: 'Where to next?',
                                filled: true,

                                fillColor: Colors.white38,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(290),),

                                hintStyle: GoogleFonts.poppins(color: Colors.grey[400], fontSize: 13),
                                prefixIcon: Icon(Icons.search, color: AppTheme.primaryColor, size: 20),
                                suffixIcon: _searchQuery.isNotEmpty
                                    ? IconButton(
                                  icon: const Icon(Icons.close, color: Colors.grey, size: 18),
                                  onPressed: () => _searchController.clear(),
                                )
                                    : null,
                                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                isDense: true,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20), // Reduced section gap
                        ],
                      ),
                    ),
                  ),

                  // 2.5 Service Grid (Dashboard) - REMOVED per user request
                  // const SliverToBoxAdapter(
                  //   child: ServiceQuickGrid(),
                  // ),

                  // 3. Highlight Carousel
                  if (highlightList.isNotEmpty) ...[
                    SliverPadding(
                      padding: const EdgeInsets.only(left: 20, bottom: 12),
                      sliver: SliverToBoxAdapter(
                        child: Text(
                          highlightTitle,
                          style: GoogleFonts.playfairDisplay( // Designer suggested font
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textPrimary,
                          ), 
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SwipeableCardStack(
                        destinations: highlightList,
                        onCardTap: _onDestinationTap,
                      ),
                    ),
                    const SliverToBoxAdapter(child: SizedBox(height: 20)),
                  ],

                  // 4. Categories
                  SliverToBoxAdapter(
                    child: CategoryChips(
                      categories: _categories,
                      selectedCategory: _selectedCategory,
                      onCategorySelected: _onCategorySelected,
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 16)),

                  // 5. Grid Header
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    sliver: SliverToBoxAdapter(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Explore Places',
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // 6. Main Grid
                  SliverPadding(
                    padding: const EdgeInsets.all(20),
                    sliver: SliverGrid(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16, // Tighter grid
                        crossAxisSpacing: 16,
                        childAspectRatio: 1.0, // Square tiles for density
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final destination = filteredDestinations[index];
                          final isFavorite = favoriteIds.contains(destination.id);
                          
                          return DestinationCard(
                            destination: destination,
                            compact: true, // Use overlay style
                            isFavorite: isFavorite,
                            onFavoriteToggle: user != null 
                              ? () => _dbService.toggleFavorite(user.uid, destination.id, isFavorite)
                              : null,
                            onTap: () => _onDestinationTap(destination),
                          );
                        },
                        childCount: filteredDestinations.length,
                      ),
                    ),
                  ),
                  
                  // Bottom spacer for Floating Nav Bar (Crucial)
                  const SliverToBoxAdapter(child: SizedBox(height: 120)),
                ],
              );
            }
          );
        }
      ),

          // 2. Custom Floating Bottom Bar
          Align(
            alignment: Alignment.bottomCenter,
            child: CustomFloatingNavBar(
              currentIndex: _currentNavIndex,
              onTap: (index) {
                if (index == 4) {
                   Navigator.pushNamed(context, '/maps');
                   return; // Don't update state index for this push
                }
                setState(() => _currentNavIndex = index);
                if (index == 3) {
                   Navigator.pushNamed(context, '/profile');
                } else if (index == 1) {
                   Navigator.pushNamed(context, '/explore');
                } else if (index == 2) {
                   Navigator.pushNamed(context, '/favorites');
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
