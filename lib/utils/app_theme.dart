import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // --- Colors ---
  // A sophisticated "Modern Explorer" palette
  // Primary: Specific Deep Teal for professional, trustworthy feel
  static const Color primaryColor = Color(0xFF0F4C5C); 
  // Secondary: Muted Gold/Sand for luxury accents
  static const Color secondaryColor = Color(0xFFE3B505); 
  // Accent: Burnt Orange for "Book Now" / Call to Actions (High visibility)
  static const Color accentColor = Color(0xFFE65100);
  
  // Backgrounds
  static const Color backgroundColor = Color(0xFFF9FAFB); // Cool light grey, easier on eyes than stark white
  static const Color surfaceColor = Colors.white;
  static const Color scaffoldBackgroundColor = Color(0xFFF9FAFB);

  // Text
  static const Color textPrimary = Color(0xFF1A1A1A); // Nearly black, softer than #000
  static const Color textSecondary = Color(0xFF6B7280); // Medium grey
  static const Color textLight = Colors.white;

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      
      // Core Colors
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      primaryColor: primaryColor,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        primary: primaryColor,
        secondary: secondaryColor,
        tertiary: accentColor,
        surface: surfaceColor,
        surfaceContainerLow: backgroundColor,
        // Ensure error colors are standard
        error: const Color(0xFFB00020),
      ),

      // Typography - POppins is excellent for mobile legibility
      textTheme: GoogleFonts.poppinsTextTheme().copyWith(
        // Giant Headers (e.g. "Discover")
        displayLarge: GoogleFonts.poppins(
          fontWeight: FontWeight.w700,
          fontSize: 34,
          color: textPrimary,
          letterSpacing: -1.0, 
        ),
        // Screen Titles
        headlineMedium: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          fontSize: 24,
          color: textPrimary,
          letterSpacing: -0.5,
        ),
        // Section Headers
        titleLarge: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          fontSize: 20,
          color: textPrimary,
        ),
        // Card Titles
        titleMedium: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: textPrimary,
        ),
        // Body text
        bodyMedium: GoogleFonts.poppins(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          color: textSecondary,
          height: 1.5, // Better readability
        ),
        // Captions / Metadata
        bodySmall: GoogleFonts.poppins(
          fontWeight: FontWeight.w500,
          fontSize: 12,
          color: textSecondary,
        ),
      ),

      // --- Component Themes ---

      // AppBar
      appBarTheme: const AppBarTheme(
        backgroundColor: backgroundColor,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: textPrimary),
      ),

      // Buttons (High prominence, accessible)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: textLight,
          elevation: 0, // Flat design
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),

      // Input Fields (Search bars, forms)
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceColor,
        contentPadding: const EdgeInsets.all(18), // Taller touch targets
        hintStyle: GoogleFonts.poppins(color: Colors.grey[400], fontSize: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none, // Clean look by default
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey[200]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: primaryColor, width: 1.5),
        ),
        // Add subtle shadow support via container decoration in widget usage
      ),

      // Card Theme
      cardTheme: CardThemeData(
        color: surfaceColor,
        elevation: 0, // We will use custom shadows
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        margin: EdgeInsets.zero,
      ),
      
      // Bottom Navigation Bar
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: surfaceColor,
        elevation: 10,
        height: 65,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        indicatorColor: primaryColor.withOpacity(0.1),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: primaryColor, size: 26);
          }
          return IconThemeData(color: Colors.grey[400], size: 26);
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
           if (states.contains(WidgetState.selected)) {
            return GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: primaryColor);
          }
          return GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.grey[500]);
        }),
      ),
    );
  }
}
