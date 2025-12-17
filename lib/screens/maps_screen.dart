import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:geolocator/geolocator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/destination.dart';
import '../services/database_service.dart';
import '../widgets/destination_card.dart';
import '../utils/app_theme.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({super.key});

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  final MapController _mapController = MapController();
  final DatabaseService _dbService = DatabaseService();
  
  // Default: London (fallback)
  latLng.LatLng _currentCenter = const latLng.LatLng(51.509364, -0.128928);
  bool _isLoadingLocation = false;

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    setState(() => _isLoadingLocation = true);
    
    bool serviceEnabled;
    LocationPermission permission;

    // 1. Check Service
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (mounted) {
         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Location services are disabled.')));
         setState(() => _isLoadingLocation = false);
      }
      return;
    }

    // 2. Check Permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (mounted) {
           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Location permissions are denied')));
           setState(() => _isLoadingLocation = false);
        }
        return;
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      if (mounted) {
         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Location permissions are permanently denied.')));
         setState(() => _isLoadingLocation = false);
      }
      return;
    } 

    // 3. Get Position
    try {
      Position position = await Geolocator.getCurrentPosition();
      if (mounted) {
        setState(() {
          _currentCenter = latLng.LatLng(position.latitude, position.longitude);
          _isLoadingLocation = false;
        });
        _mapController.move(_currentCenter, 15.0);
      }
    } catch (e) {
      debugPrint("Error getting location: $e");
      if (mounted) setState(() => _isLoadingLocation = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Map Layer
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _currentCenter,
              initialZoom: 13.0,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.travel_app',
              ),
              MarkerLayer(
                markers: [
                  // User Location Marker
                  Marker(
                    point: _currentCenter,
                    width: 60,
                    height: 60,
                    child: const Icon(Icons.my_location, color: Colors.blue, size: 30),
                  ),
                  // Mock Hotel Marker (Nearby)
                  Marker(
                    point: latLng.LatLng(_currentCenter.latitude + 0.005, _currentCenter.longitude + 0.005),
                    width: 50,
                    height: 50,
                    child: _buildMapPin(Icons.hotel),
                  ),
                ],
              ),
            ],
          ),

          // 2. Floating Header (Search)
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30), // Pill shape
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0,4)),
                ],
              ),
              child: Row(
                children: [
                   IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Expanded(
                    child: Text(
                      "Search area...",
                      style: GoogleFonts.poppins(color: Colors.grey[600]),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: Icon(Icons.search, color: Colors.black54),
                  ),
                ],
              ),
            ),
          ),

          // 3. My Location Button
          Positioned(
            right: 20,
            bottom: 260, // Above the carousel
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              mini: true,
              onPressed: _determinePosition,
              child: _isLoadingLocation 
                ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                : const Icon(Icons.my_location, color: Colors.black87),
            ),
          ),

          // 4. Bottom Sheet List
          Positioned(
            bottom: 30, 
            left: 0,
            right: 0,
            height: 220,
            child: StreamBuilder<List<Destination>>(
              stream: _dbService.getDestinations(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const SizedBox.shrink();
                final destinations = snapshot.data!;
                
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: destinations.length,
                  itemBuilder: (context, index) {
                    final dest = destinations[index];
                    return Container(
                      width: 280,
                      margin: const EdgeInsets.only(right: 16),
                      child: DestinationCard(
                        destination: dest,
                        compact: true, 
                        onTap: () => Navigator.pushNamed(context, '/details', arguments: dest),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapPin(IconData icon) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: AppTheme.primaryColor,
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2))],
          ),
          child: Icon(icon, color: Colors.white, size: 16),
        ),
        ClipPath(
          clipper: TriangleClipper(),
          child: Container(
            width: 10,
            height: 8,
            color: AppTheme.primaryColor,
          ),
        ),
      ],
    );
  }
}

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width / 2, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
