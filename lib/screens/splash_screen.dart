import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

/// Splash Screen with fade animation
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to Login Screen after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [const Color(0xFF4A90E2), const Color(0xFF50C9C3)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo/Icon
              Icon(Icons.explore, size: 120, color: Colors.white)
                  .animate()
                  .fadeIn(duration: 1000.ms)
                  .scale(delay: 200.ms, duration: 800.ms),

              const SizedBox(height: 30),

              // App Name
              Text(
                    'Travel Explorer',
                    style: GoogleFonts.poppins(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )
                  .animate()
                  .fadeIn(delay: 500.ms, duration: 1000.ms)
                  .slideY(begin: 0.3, end: 0),

              const SizedBox(height: 10),

              // Subtitle
              Text(
                'Discover Pakistan',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.white70,
                ),
              ).animate().fadeIn(delay: 800.ms, duration: 1000.ms),
            ],
          ),
        ),
      ),
    );
  }
}
