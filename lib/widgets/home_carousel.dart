import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/destination.dart';
import '../utils/app_theme.dart';

class HomeCarousel extends StatelessWidget {
  final List<Destination> destinations;
  final Function(Destination) onDestinationTap;

  const HomeCarousel({
    super.key,
    required this.destinations,
    required this.onDestinationTap,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 220.0, // Compact Hero height
        viewportFraction: 0.92, // Almost full width
        enlargeCenterPage: false, // Flat professional slider
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 5),
        autoPlayCurve: Curves.easeOutQuart,
        enableInfiniteScroll: true,
      ),
      items: destinations.map((destination) {
        return Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () => onDestinationTap(destination),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 6), // Gutter
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      offset: const Offset(0, 8),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Background Image
                      Image.network(
                        destination.imageUrl,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            color: Colors.grey[200],
                            child: const Center(child: CircularProgressIndicator()),
                          );
                        },
                        errorBuilder: (context, _, __) => Container(
                          color: Colors.grey[300],
                          child: const Icon(Icons.broken_image, color: Colors.grey),
                        ),
                      ),
                      
                      // Gradient Overlay - Professional grade (Top-down + Bottom-up)
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.transparent,
                              Colors.black.withOpacity(0.7), // Text legibility
                            ],
                            stops: const [0.0, 0.5, 1.0],
                          ),
                        ),
                      ),

                      // Content Overlay
                      Positioned(
                        bottom: 24,
                        left: 24,
                        right: 24,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // "Featured" or Tag
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppTheme.accentColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                destination.category.toUpperCase(),
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              destination.name,
                              style: GoogleFonts.poppins(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(Icons.location_on, color: Colors.white70, size: 14),
                                const SizedBox(width: 4),
                                Text(
                                  destination.location,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: Colors.white.withOpacity(0.9),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
