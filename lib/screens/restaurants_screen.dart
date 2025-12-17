import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/destination.dart';
import '../models/restaurant.dart';
import '../services/database_service.dart';
import '../utils/app_theme.dart';

class RestaurantsScreen extends StatelessWidget {
  const RestaurantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final destination = ModalRoute.of(context)?.settings.arguments as Destination?;
    final dbService = DatabaseService();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          destination != null ? 'Restaurants' : 'All Restaurants', 
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600)
        ),
        backgroundColor: const Color(0xFF50C9C3),
        foregroundColor: Colors.white,
      ),
      body: StreamBuilder<List<Restaurant>>(
        stream: dbService.getRestaurants(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final allRestaurants = snapshot.data ?? [];
          final restaurants = destination != null 
              ? allRestaurants.where((r) => destination.restaurants.contains(r.id)).toList()
              : allRestaurants;

          if (restaurants.isEmpty) {
             return const Center(child: Text('No restaurants connected to this destination yet.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: restaurants.length,
            itemBuilder: (context, index) {
              final restaurant = restaurants[index]; // Fixed variable name from hotel to restaurant
              return Card(
                elevation: 3,
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          restaurant.imageUrl,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                          errorBuilder: (ctx, err, stack) => Container(width: 100, height: 100, color: Colors.grey[200]),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(restaurant.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            Text(restaurant.cuisine, style: const TextStyle(color: Color(0xFF50C9C3), fontSize: 12, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text(restaurant.priceRange, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(Icons.star, size: 16, color: Colors.amber),
                                Text(restaurant.rating.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
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
          );
        },
      ),
    );
  }
}
