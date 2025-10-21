import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/sample_data.dart';
import '../widgets/category_card.dart';
import '../widgets/destination_card.dart';

/// Home Screen with categories and recommended destinations
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    // Filter destinations based on search
    final filteredDestinations = destinations.where((dest) {
      return dest.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
          dest.location.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hi Maryam 👋',
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Ready to explore Pakistan?',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.notifications_outlined, size: 28),
                    ),
                  ],
                ),

                const SizedBox(height: 25),

                // Search Bar
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Search destinations...',
                      border: InputBorder.none,
                      icon: const Icon(Icons.search, color: Colors.grey),
                      hintStyle: GoogleFonts.poppins(color: Colors.grey[400]),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Categories Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Categories',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Row(
                        children: [
                          Icon(Icons.filter_list, size: 20),
                          const SizedBox(width: 5),
                          Text('Filter', style: GoogleFonts.poppins()),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                // Categories Grid
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 1.5,
                  children: [
                    CategoryCard(
                      title: 'Mountains',
                      icon: Icons.landscape,
                      color: const Color(0xFF4A90E2),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/destinations',
                          arguments: 'Mountains',
                        );
                      },
                    ),
                    CategoryCard(
                      title: 'Beaches',
                      icon: Icons.beach_access,
                      color: const Color(0xFF50C9C3),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/destinations',
                          arguments: 'Beaches',
                        );
                      },
                    ),
                    CategoryCard(
                      title: 'Historical',
                      icon: Icons.account_balance,
                      color: const Color(0xFFE07A5F),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/destinations',
                          arguments: 'Historical',
                        );
                      },
                    ),
                    CategoryCard(
                      title: 'Lakes',
                      icon: Icons.water,
                      color: const Color(0xFF81B29A),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/destinations',
                          arguments: 'Lakes',
                        );
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // Recommended Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recommended',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                // Recommended Destinations
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: filteredDestinations.take(5).length,
                  itemBuilder: (context, index) {
                    final destination = filteredDestinations[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: DestinationCard(
                        destination: destination,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/details',
                            arguments: destination,
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF4A90E2),
        unselectedItemColor: Colors.grey,
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            Navigator.pushNamed(context, '/favorites');
          } else if (index == 3) {
            Navigator.pushNamed(context, '/about');
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Explore'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
