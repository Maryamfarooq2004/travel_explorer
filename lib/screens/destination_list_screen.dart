import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/destination.dart';
import '../services/database_service.dart';
import '../widgets/destination_card.dart';
import '../utils/app_theme.dart';

class DestinationListScreen extends StatelessWidget {
  const DestinationListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get category from route arguments
    final category = ModalRoute.of(context)?.settings.arguments as String?;
    final dbService = DatabaseService();

    if (category == null) {
      return const Scaffold(body: Center(child: Text('Category Not Found')));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(category, style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: StreamBuilder<List<Destination>>(
        stream: dbService.getDestinations(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final allDestinations = snapshot.data ?? [];
          final filteredDestinations = allDestinations
              .where((dest) => dest.category == category)
              .toList();

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${filteredDestinations.length} places found',
                  style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600]),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: filteredDestinations.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.search_off, size: 60, color: Colors.grey[300]),
                              const SizedBox(height: 16),
                              Text(
                                'No destinations found in this category',
                                style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey),
                              ),
                            ],
                          ),
                        )
                      : ListView.separated(
                          itemCount: filteredDestinations.length,
                          separatorBuilder: (ctx, i) => const SizedBox(height: 16),
                          itemBuilder: (context, index) {
                            final destination = filteredDestinations[index];
                            return DestinationCard(
                              destination: destination,
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  '/details',
                                  arguments: destination,
                                );
                              },
                            );
                          },
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
