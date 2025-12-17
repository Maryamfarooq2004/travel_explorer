import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_theme.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              // App Icon with Pulse
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.explore, size: 64, color: AppTheme.primaryColor),
              ),
              const SizedBox(height: 24),
              
              Text(
                'Travel Explorer',
                style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              Text(
                'Version 2.0.0 (Cloud Edition)',
                style: GoogleFonts.poppins(color: Colors.grey),
              ),
              const SizedBox(height: 40),

              _buildSection(
                title: 'Overview',
                content: 'Travel Explorer Pakistan is your smart companion for discovering the beauty of Pakistan. Now powered by the Cloud, it offers real-time updates on destinations, hotels, and restaurants.',
              ),
              const SizedBox(height: 24),

              _buildSection(
                title: 'Key Features',
                content: '',
                child: Column(
                  children: [
                    _buildFeatureItem(Icons.cloud_done, 'Real-time Data Sync'),
                    _buildFeatureItem(Icons.favorite, 'Cloud Favorites'),
                    _buildFeatureItem(Icons.star, 'Community Reviews'),
                    _buildFeatureItem(Icons.map, 'Interactive Exploration'),
                  ],
                ),
              ),
               const SizedBox(height: 24),
              _buildSection(
                title: 'Development Team',
                content: '',
                child: Column(
                  children: [
                     _buildTeamMember('Kaleem', 'Lead Architect & AI Engineer'), 
                     // Add other members as needed
                  ],
                ),
              ),

              const SizedBox(height: 48),
              Text(
                '© 2025 Travel Explorer Pakistan',
                style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[400]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required String content, Widget? child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 15, offset: const Offset(0, 5)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
          if (content.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(content, style: GoogleFonts.poppins(color: Colors.grey[700], height: 1.5)),
          ],
          if (child != null) ...[
            const SizedBox(height: 16),
            child,
          ],
        ],
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppTheme.primaryColor),
          const SizedBox(width: 12),
          Text(text, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildTeamMember(String name, String role) {
    return Padding(
       padding: const EdgeInsets.only(bottom: 12),
       child: Row(
         children: [
           CircleAvatar(
             radius: 18,
             backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
             child: Text(name[0], style: TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.bold)),
           ),
           const SizedBox(width: 12),
           Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Text(name, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600)),
               Text(role, style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey)),
             ],
           ),
         ],
       ),
    );
  }
}
