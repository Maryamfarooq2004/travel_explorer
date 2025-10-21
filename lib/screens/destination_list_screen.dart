import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/sample_data.dart';
import '../widgets/destination_card.dart';

/// Destination List Screen filtered by category
class DestinationListScreen extends StatelessWidget {
  const DestinationListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get category from route arguments
    final category = ModalRoute.of(context)!.settings.arguments as String;

    // Filter destinations by category
    final filteredDestinations = destinations
        .where((dest) => dest.category == category)
        .toList();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          category,
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color(0xFF4A90E2),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${filteredDestinations.length} destinations found',
              style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: filteredDestinations.isEmpty
                  ? Center(
                      child: Text(
                        'No destinations found',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            mainAxisSpacing: 15,
                            childAspectRatio: 1.8,
                          ),
                      itemCount: filteredDestinations.length,
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
      ),
    );
  }
}
