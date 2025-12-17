
import 'dart:convert';
import 'dart:io';

// Import data and models
// We use relative paths assuming this script is run from the project root
// e.g., dart scripts/export_data.dart
import '../lib/data/sample_data.dart';
import '../lib/models/destination.dart';
import '../lib/models/city.dart';

void main() async {
  print('Exporting data to JSON...');

  // 1. Export Destinations
  final destinationsJson = destinations.map((d) => d.toJson()).toList();
  final destinationsFile = File('scripts/destinations.json');
  await destinationsFile.writeAsString(jsonEncode(destinationsJson));
  print('Exported ${destinations.length} destinations to ${destinationsFile.path}');

  // 2. Export Cities (Optional, but useful)
  final citiesJson = cities.map((c) => c.toJson()).toList();
  final citiesFile = File('scripts/cities.json');
  await citiesFile.writeAsString(jsonEncode(citiesJson));
  print('Exported ${cities.length} cities to ${citiesFile.path}');
  
  print('Done!');
}
