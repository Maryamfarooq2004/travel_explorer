import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import '../models/destination.dart';
import '../data/sample_data.dart';

/// Hotels Screen showing nearby hotels
class HotelsScreen extends StatelessWidget {
  const HotelsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final destination = ModalRoute.of(context)!.settings.arguments as Destination;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          'Hotels Nearby',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color(0xFF4A90E2),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Best hotels near ${destination.name}',
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: hotels.length,
                itemBuilder: (context, index) {
                  final hotel = hotels[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 15),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Hotel Image
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(15),
                          ),
                          child: Image.network(
                            hotel.imageUrl,
                            height: 180,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: 180,
                                color: Colors.grey[300],
                                child: const Icon(Icons.hotel, size: 50),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                hotel.name,
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(
                                    Iconsax.location,
                                    size: 16,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    child: Text(
                                      hotel.location,
                                      style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        size: 18,
                                        color: Colors.amber,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        hotel.rating.toString(),
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    hotel.price,
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF4A90E2),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text(
                                hotel.description,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
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
