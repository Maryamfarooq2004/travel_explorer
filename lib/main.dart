import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'firebase_options.dart';
import 'services/auth_service.dart';
import 'utils/app_theme.dart';
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
import 'screens/reviews_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/maps_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const TravelExplorerApp());
}

class TravelExplorerApp extends StatelessWidget {
  const TravelExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel Explorer Pakistan',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const AuthWrapper(),

      // Named Routes
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/home': (context) => const HomeScreen(),
        '/explore': (context) => const ExploreScreen(),
        '/destinations': (context) => const DestinationListScreen(),
        '/details': (context) => const DetailsScreen(),
        '/hotels': (context) => const HotelsScreen(),
        '/restaurants': (context) => const RestaurantsScreen(),
        '/reviews': (context) => const ReviewsScreen(),
        '/favorites': (context) => const FavoritesScreen(),
        '/about': (context) => const AboutScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/maps': (context) => const MapsScreen(),
      },
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: AuthService().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashScreen(); // Or a loading indicator
        } else if (snapshot.hasData) {
          return const HomeScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
