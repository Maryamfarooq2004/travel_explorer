import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import '../models/destination.dart';
import '../data/sample_data.dart';

/// Restaurants Screen showing nearby restaurants
class RestaurantsScreen extends StatelessWidget {
  const RestaurantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final destination = ModalRoute.of(context)!.settings.arguments as Destination;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          'Restaurants',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color(0xFF50C9C3),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Best restaurants near ${destination.name}',
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: restaurants.length,
                itemBuilder: (context, index) {
                  final restaurant = restaurants[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 15),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          // Restaurant Image
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              restaurant.imageUrl,
                              height: 90,
                              width: 90,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  height: 90,
                                  width: 90,
                                  color: Colors.grey[300],
                                  child: const Icon(Icons.restaurant, size: 40),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 15),
                          // Restaurant Info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  restaurant.name,
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    const Icon(
                                      Iconsax.location,
                                      size: 14,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      restaurant.location,
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  restaurant.cuisine,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: const Color(0xFF50C9C3),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          size: 16,
                                          color: Colors.amber,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          restaurant.rating.toString(),
                                          style: GoogleFonts.poppins(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      restaurant.priceRange,
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: Colors.grey[700],
                                        fontWeight: FontWeight.w500,
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
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
