import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/destination.dart';
import '../utils/app_theme.dart';

class SwipeableCardStack extends StatefulWidget {
  final List<Destination> destinations;
  final Function(Destination) onCardTap;

  const SwipeableCardStack({
    super.key,
    required this.destinations,
    required this.onCardTap,
  });

  @override
  State<SwipeableCardStack> createState() => _SwipeableCardStackState();
}

class _SwipeableCardStackState extends State<SwipeableCardStack> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.destinations.isEmpty) return const SizedBox.shrink();

    // If we've swiped through everything, maybe show a reset or "All Caught Up"
    if (_currentIndex >= widget.destinations.length) {
      return Container(
        height: 220,
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle_outline, size: 48, color: Colors.grey),
            const SizedBox(height: 12),
            Text(
              "You've seen them all!",
              style: GoogleFonts.poppins(color: Colors.grey),
            ),
            TextButton(
              onPressed: () => setState(() => _currentIndex = 0),
              child: const Text("Start Over"),
            ),
          ],
        ),
      );
    }

    // Determine which cards to show (Max 3 at a time for performance/visuals)
    final visibleItems = widget.destinations.sublist(
      _currentIndex,
      (_currentIndex + 3).clamp(0, widget.destinations.length),
    );

    return SizedBox(
      height: 240, // Height for the stack container
      child: Stack(
        alignment: Alignment.center,
        children: visibleItems.asMap().entries.map((entry) {
          final index = entry.key; // 0 = top, 1 = under, 2 = bottom
          final destination = entry.value;
          
          // Calculate layout properties based on stack index
          final double topOffset = index * 12.0;
          final double scale = 1.0 - (index * 0.05);
          final double opacity = 1.0 - (index * 0.2); // Fade out deeper cards

          // The Top card is Dismissible
          if (index == 0) {
            return Positioned(
              top: 0,
              child: Dismissible(
                key: Key('card-${destination.id}'),
                direction: DismissDirection.horizontal,
                onDismissed: (direction) {
                  setState(() {
                    _currentIndex++;
                  });
                },
                child: _buildCardContent(destination, scale: 1.0),
              ),
            );
          }

          // Background cards are just animated containers
          return Positioned(
            top: topOffset,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: opacity,
              child: Transform.scale(
                scale: scale,
                child: _buildCardContent(destination, scale: scale, isBackground: true),
              ),
            ),
          );
        }).toList().reversed.toList(), // Reverse so first item (0) is on TOP of stack
      ),
    );
  }

  Widget _buildCardContent(Destination destination, {required double scale, bool isBackground = false}) {
    // Width set to match standard device width minus margins
    // We hardcode a width or use media query context usually, but here fixed width helps the stack alignment
    const double cardWidth = 340; 
    
    return GestureDetector(
      onTap: isBackground ? null : () => widget.onCardTap(destination),
      child: Container(
        height: 220,
        width: cardWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              offset: const Offset(0, 8),
              blurRadius: 20,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Image
              Image.network(
                destination.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_,__,___) => Container(color: Colors.grey[200]),
              ),
              
              // Gradient & Text
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                    stops: const [0.5, 1.0],
                  ),
                ),
              ),
              
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      destination.name,
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.location_on, color: Colors.white70, size: 14),
                        const SizedBox(width: 4),
                        Text(
                          destination.location,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // "Swipe" hint (optional)
              if (!isBackground)
                const Positioned(
                  top: 20,
                  right: 20,
                  child: Icon(Icons.swipe, color: Colors.white54, size: 20),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
