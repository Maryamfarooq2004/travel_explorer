import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/city.dart';
import '../models/destination.dart';
import '../services/database_service.dart';
import '../widgets/destination_card.dart';
import '../utils/app_theme.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dbService = DatabaseService();

    return Scaffold(
      appBar: AppBar(
        title: Text('Explore by City', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: StreamBuilder<List<City>>(
        stream: dbService.getCities(),
        builder: (context, citySnapshot) {
          if (citySnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final cities = citySnapshot.data ?? [];
          
          if (cities.isEmpty) {
             return Center(child: Text("No cities found", style: GoogleFonts.poppins(color: Colors.grey)));
          }

          // We also need destinations to filter by city
          return StreamBuilder<List<Destination>>(
            stream: dbService.getDestinations(),
            builder: (context, destSnapshot) {
              final destinations = destSnapshot.data ?? [];
              
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: cities.length,
                itemBuilder: (context, index) {
                  final city = cities[index];
                  // Filter destinations for this city
                  final cityDestinations = destinations.where((d) => city.destinationIds.contains(d.id)).toList();
                  
                  return CityCard(city: city, cityDestinations: cityDestinations);
                },
              );
            },
          );
        },
      ),
    );
  }
}

class CityCard extends StatelessWidget {
  final City city;
  final List<Destination> cityDestinations;

  const CityCard({super.key, required this.city, required this.cityDestinations});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 24),
      elevation: 6,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // City Image Header
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Stack(
              children: [
                Image.network(
                  city.imageUrl,
                  height: 220,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 220,
                      color: Colors.grey[300],
                      child: const Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
                    );
                  },
                ),
                // Gradient Overlay
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.8),
                        ],
                        stops: const [0.6, 1.0],
                      ),
                    ),
                  ),
                ),
                // City Info
                Positioned(
                  bottom: 16,
                  left: 20,
                  right: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Text(
                            city.name,
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                             decoration: BoxDecoration(
                               color: Colors.white.withOpacity(0.2),
                               borderRadius: BorderRadius.circular(8),
                             ),
                             child: Text(
                                city.province,
                                style: GoogleFonts.poppins(color: Colors.white, fontSize: 12),
                             ),
                          ),
                         ],
                       ),
                      const SizedBox(height: 4),
                      Text(
                        city.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Places to Visit
          if (cityDestinations.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                children: [
                  Icon(Icons.place, size: 18, color: AppTheme.primaryColor),
                  const SizedBox(width: 8),
                  Text(
                    'Places to Visit',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${cityDestinations.length} places',
                    style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 250,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: cityDestinations.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: 280,
                    margin: const EdgeInsets.only(right: 16, bottom: 16),
                    child: DestinationCard(
                      destination: cityDestinations[index],
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/details',
                          arguments: cityDestinations[index],
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ] else
            Padding(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: Text(
                  'No destinations added yet.',
                  style: GoogleFonts.poppins(
                    color: Colors.grey[500],
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
