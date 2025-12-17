import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class CategoryChips extends StatelessWidget {
  final List<String> categories;
  final String selectedCategory;
  final Function(String) onCategorySelected;

  const CategoryChips({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 34, // Compact height
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8), // Tighter gap
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = category == selectedCategory;
          
          return ActionChip(
            label: Text(category),
            padding: EdgeInsets.zero, // Minimal padding
            labelPadding: const EdgeInsets.symmetric(horizontal: 12),
            
            // Clean/Minimal styles
            backgroundColor: isSelected ? AppTheme.primaryColor : Colors.white,
            disabledColor: Colors.grey[100],
            
            // Text Style
            labelStyle: TextStyle(
              color: isSelected ? Colors.white : Colors.grey[600],
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              fontSize: 12, // Smaller font
              fontFamily: 'Poppins', 
            ),
            
            // Border logic
            side: BorderSide(
              color: isSelected 
                ? Colors.transparent 
                : Colors.grey.withOpacity(0.3),
              width: 1,
            ),
            
            // Shape
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            
            elevation: isSelected ? 2 : 0, 
            pressElevation: 2,
            
            onPressed: () => onCategorySelected(category),
          );
        },
      ),
    );
  }
}
