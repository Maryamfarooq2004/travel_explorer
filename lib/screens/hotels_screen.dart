import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/destination.dart';
import '../models/hotel.dart';
import '../services/database_service.dart';
import '../utils/app_theme.dart';

class HotelsScreen extends StatelessWidget {
  const HotelsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Get arguments safely (nullable)
    final destination = ModalRoute.of(context)?.settings.arguments as Destination?;
    final dbService = DatabaseService();

    return Scaffold(
      appBar: AppBar(
        // 2. Dynamic Title
        title: Text(
          destination != null ? 'Hotels (Nearby)' : 'All Hotels', 
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600)
        ),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: StreamBuilder<List<Hotel>>(
        stream: dbService.getHotels(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final allHotels = snapshot.data ?? [];
          
          // 3. Optional Filtering
          final hotels = destination != null 
              ? allHotels.where((h) => destination.hotels.contains(h.id)).toList()
              : allHotels;

          if (hotels.isEmpty) {
             return const Center(child: Text('No hotels connected to this destination yet.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: hotels.length,
            itemBuilder: (context, index) {
              final hotel = hotels[index];
              return Card(
                elevation: 4,
                margin: const EdgeInsets.only(bottom: 20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                      child: Image.network(
                        hotel.imageUrl,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                         errorBuilder: (ctx, err, stack) => Container(height: 200, color: Colors.grey[200]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(hotel.name, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                              Text(hotel.price, style: TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(hotel.location, style: Theme.of(context).textTheme.bodySmall),
                          const SizedBox(height: 8),
                          Text(hotel.description, maxLines: 2, overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
