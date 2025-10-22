import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'screens/about_screen.dart';
import 'screens/destination_list_screen.dart';
import 'screens/details_screen.dart';
import 'screens/explore_screen.dart';
import 'screens/favorites_screen.dart';
import 'screens/home_screen.dart';
import 'screens/hotels_screen.dart';
import 'screens/login_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/restaurants_screen.dart';
// Screens
import 'screens/splash_screen.dart';

void main() {
  runApp(const TravelExplorerApp());
}

class TravelExplorerApp extends StatelessWidget {
  const TravelExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel Explorer Pakistan',
      debugShowCheckedModeBanner: false,

      // Theme
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4A90E2),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(),
        appBarTheme: AppBarTheme(
          elevation: 0,
          centerTitle: true,
          titleTextStyle: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),

      // Initial Route
      initialRoute: '/',

      // Named Routes
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/explore': (context) => const ExploreScreen(),
        '/destinations': (context) => const DestinationListScreen(),
        '/details': (context) => const DetailsScreen(),
        '/hotels': (context) => const HotelsScreen(),
        '/restaurants': (context) => const RestaurantsScreen(),
        '/favorites': (context) => const FavoritesScreen(),
        '/about': (context) => const AboutScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
    );
  }
}
