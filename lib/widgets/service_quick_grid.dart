import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../utils/app_theme.dart';

class ServiceQuickGrid extends StatelessWidget {
  const ServiceQuickGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildServiceItem(context, 'Hotels', FontAwesomeIcons.hotel, Colors.orangeAccent, '/hotels'),
          _buildServiceItem(context, 'Food', FontAwesomeIcons.utensils, Colors.redAccent, '/restaurants'),
          _buildServiceItem(context, 'All Places', FontAwesomeIcons.mapLocationDot, Colors.blueAccent, '/destinations'), 
          _buildServiceItem(context, 'Cities', FontAwesomeIcons.city, Colors.purpleAccent, '/explore'),
        ],
      ),
    );
  }

  Widget _buildServiceItem(BuildContext context, String label, IconData icon, Color color, String route) {
    return GestureDetector(
      onTap: () {
        if (route.isNotEmpty) {
           Navigator.pushNamed(context, route);
        } else {
           ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$label Coming Soon!")));
        }
      },
      child: Column(
        children: [
          Container(
            height: 56,
            width: 56,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Center(
              child: FaIcon(icon, size: 22, color: color),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppTheme.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
