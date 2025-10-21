import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import '../models/destination.dart';
import '../utils/favorites_manager.dart';
import '../widgets/custom_button.dart';
import '../widgets/rating_star.dart';

/// Details Screen showing destination information
class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool isFavorite = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _checkFavoriteStatus();
  }

  Future<void> _checkFavoriteStatus() async {
    final destination = ModalRoute.of(context)!.settings.arguments as Destination;
    final favorite = await FavoritesManager.isFavorite(destination.id);
    setState(() {
      isFavorite = favorite;
    });
  }

  Future<void> _toggleFavorite() async {
    final destination = ModalRoute.of(context)!.settings.arguments as Destination;
    
    if (isFavorite) {
      await FavoritesManager.removeFavorite(destination.id);
    } else {
      await FavoritesManager.addFavorite(destination);
    }
    
    setState(() {
      isFavorite = !isFavorite;
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isFavorite ? 'Added to favorites' : 'Removed from favorites',
          style: GoogleFonts.poppins(),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final destination = ModalRoute.of(context)!.settings.arguments as Destination;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar with Hero Image
          SliverAppBar(
            expandedHeight: 350,
            pinned: true,
            backgroundColor: const Color(0xFF4A90E2),
            foregroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    destination.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[300],
                        child: const Icon(Icons.image, size: 100),
                      );
                    },
                  ),
                  // Gradient overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              IconButton(
                onPressed: _toggleFavorite,
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : Colors.white,
                ),
              ),
            ],
          ),
          
          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    destination.name,
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  const SizedBox(height: 10),
                  
                  // Location
                  Row(
                    children: [
                      const Icon(
                        Iconsax.location,
                        size: 18,
                        color: Color(0xFF4A90E2),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          destination.location,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 15),
                  
                  // Rating
                  Row(
                    children: [
                      RatingStar(rating: destination.rating),
                      const SizedBox(width: 10),
                      Text(
                        destination.rating.toString(),
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 25),
                  
                  // Details Header
                  Text(
                    'Details',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  const SizedBox(height: 10),
                  
                  // Description
                  Text(
                    destination.description,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      height: 1.6,
                      color: Colors.grey[700],
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  
                  const SizedBox(height: 30),
                  
                  // Action Buttons
                  CustomButton(
                    text: 'Find Hotels Nearby',
                    icon: Iconsax.building,
                    color: const Color(0xFF4A90E2),
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/hotels',
                        arguments: destination,
                      );
                    },
                  ),
                  
                  const SizedBox(height: 15),
                  
                  CustomButton(
                    text: 'View Restaurants',
                    icon: Iconsax.cup,
                    color: const Color(0xFF50C9C3),
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/restaurants',
                        arguments: destination,
                      );
                    },
                  ),
                  
                  const SizedBox(height: 15),
                  
                  CustomButton(
                    text: 'View Reviews',
                    icon: Iconsax.message,
                    color: const Color(0xFFE07A5F),
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/reviews',
                        arguments: destination,
                      );
                    },
                  ),
                  
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
