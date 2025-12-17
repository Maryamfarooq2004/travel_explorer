import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../utils/app_theme.dart';

class CustomFloatingNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomFloatingNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10), // Reduced vertical padding
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 20), // More compact width
      decoration: BoxDecoration(
        color: const Color(0xFF2C3E50), 
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildNavItem(icon: Icons.home_rounded, index: 0),
          _buildNavItem(icon: Icons.explore_rounded, index: 1),
          
          // Center "Map" Button (Google Maps Icon Style)
          GestureDetector(
            onTap: () => onTap(4), // Special index for Map
            child: Container(
              height: 42, // Smaller Reference 48->42
              width: 42,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8),
                ],
              ),
              child: Center(
                child: FaIcon(
                  FontAwesomeIcons.mapLocationDot, // Google Maps style icon
                  color: AppTheme.primaryColor, 
                  size: 20
                ),
              ),
            ),
          ),

          _buildNavItem(icon: Icons.bookmark_rounded, index: 2),
          _buildNavItem(icon: Icons.person_rounded, index: 3),
        ],
      ),
    );
  }

  Widget _buildNavItem({required IconData icon, required int index}) {
    final isSelected = currentIndex == index;
    return GestureDetector(
      onTap: () => onTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: isSelected ? const Color(0xFF2C3E50) : Colors.white.withOpacity(0.8),
          size: 24,
        ),
      ),
    );
  }
}
