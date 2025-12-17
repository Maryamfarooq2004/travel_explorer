import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/destination.dart';
import '../services/database_service.dart';
import '../widgets/destination_card.dart';
import '../utils/app_theme.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final dbService = DatabaseService();

    if (user == null) {
      return const Scaffold(body: Center(child: Text('Please login to view favorites')));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('My Wishlist', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: StreamBuilder<List<Destination>>(
        stream: dbService.getDestinations(),
        builder: (context, destSnapshot) {
          if (destSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final allDestinations = destSnapshot.data ?? [];

          return StreamBuilder<List<String>>(
            stream: dbService.getFavoriteIds(user.uid),
            builder: (context, favSnapshot) {
              if (favSnapshot.connectionState == ConnectionState.waiting) {
                 return const Center(child: CircularProgressIndicator());
              }
              final favIds = favSnapshot.data ?? [];
              final favorites = allDestinations.where((d) => favIds.contains(d.id)).toList();

              if (favorites.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.favorite_border, size: 80, color: Colors.grey[300]),
                      const SizedBox(height: 16),
                      Text('No favorites yet', style: GoogleFonts.poppins(fontSize: 18, color: Colors.grey)),
                    ],
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  final destination = favorites[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: SizedBox(
                      height: 260, // Fixed height to satisfy Expanded widgets
                      child: DestinationCard(
                        destination: destination,
                        onTap: () => Navigator.pushNamed(context, '/details', arguments: destination),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
