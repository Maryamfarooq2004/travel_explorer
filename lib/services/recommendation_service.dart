
import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import '../models/destination.dart';

class RecommendationService {
  Interpreter? _interpreter;
  Map<String, int>? _tagMapping;
  bool _isModelLoaded = false;

  RecommendationService();

  Future<void> init() async {
    try {
      // Load Model
      _interpreter = await Interpreter.fromAsset('assets/recommendation_model.tflite');
      
      // Load Tag Mapping
      final jsonString = await rootBundle.loadString('assets/tag_mapping.json');
      _tagMapping = Map<String, int>.from(json.decode(jsonString));
      
      _isModelLoaded = true;
      print('Recommendation Model Loaded Successfully');
    } catch (e) {
      print('Error loading Recommendation Model: $e');
      print('Make sure recommendation_model.tflite exists in assets/');
    }
  }

  // Generate a recommendation vector based on user favorites
  List<double> _getUserProfileVector(List<Destination> favoriteDestinations) {
    if (_tagMapping == null) return [];
    
    int numTags = _tagMapping!.length;
    List<double> userVector = List.filled(numTags, 0.0);

    for (var dest in favoriteDestinations) {
      for (var tag in dest.tags) {
        if (_tagMapping!.containsKey(tag)) {
          int index = _tagMapping![tag]!;
          userVector[index] = 1.0; 
        }
      }
    }
    return userVector;
  }

  List<double> _getDestinationVector(Destination dest) {
    if (_tagMapping == null) return [];
    int numTags = _tagMapping!.length;
    List<double> destVector = List.filled(numTags, 0.0);

    for (var tag in dest.tags) {
      if (_tagMapping!.containsKey(tag)) {
        destVector[ _tagMapping![tag]! ] = 1.0;
      }
    }
    return destVector;
  }

  // Core Recommendation Logic
  List<Destination> recommend(
      List<Destination> allDestinations, List<Destination> userFavorites) {
    
    if (userFavorites.isEmpty) {
      // Cold start: Return random or top rated
      return List.from(allDestinations)..shuffle();
    }

    if (!_isModelLoaded || _tagMapping == null || _interpreter == null) {
      return _fallbackRecommendation(allDestinations, userFavorites);
    }

    try {
      // Use a Max-Score strategy:
      // For each favorite item, predict its "Ideal Neighbor".
      // Score candidates based on similarity to *any* of these ideals.
      // Take the MAX similarity found across all favorites.
      
      Map<String, double> finalScores = {};
      
      for (var fav in userFavorites) {
         // 1. Get vector for this specific favorite
         List<double> favVector = _getDestinationVector(fav);
         
         // 2. Run Inference to get "Ideal" expansion for this favorite
         var input = [favVector];
         var output = List.generate(1, (index) => List.filled(_tagMapping!.length, 0.0));
         _interpreter!.run(input, output);
         List<double> idealVector = output[0];
         
         // 3. Score all candidates against this ideal
         for (var dest in allDestinations) {
             if (userFavorites.any((f) => f.id == dest.id)) continue;
             
             List<double> destVector = _getDestinationVector(dest);
             double score = _cosineSimilarity(idealVector, destVector);
             
             // Keep the highest score for this destination
             if (!finalScores.containsKey(dest.id) || score > finalScores[dest.id]!) {
                 finalScores[dest.id] = score;
             }
         }
      }

      // Sort findings by score
      List<Destination> recommendations = [];
      var sortedEntries = finalScores.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));
        
      for (var entry in sortedEntries) {
          var dest = allDestinations.firstWhere((d) => d.id == entry.key);
          recommendations.add(dest);
      }
      
      return recommendations;

    } catch (e) {
      print("Inference Error: $e");
      return _fallbackRecommendation(allDestinations, userFavorites);
    }
  }

  double _cosineSimilarity(List<double> a, List<double> b) {
    double dotProduct = 0.0;
    double normA = 0.0;
    double normB = 0.0;

    for (int i = 0; i < a.length; i++) {
      dotProduct += a[i] * b[i];
      normA += a[i] * a[i];
      normB += b[i] * b[i];
    }

    if (normA == 0 || normB == 0) return 0.0;
    return dotProduct / (sqrt(normA) * sqrt(normB));
  }

  List<Destination> _fallbackRecommendation(List<Destination> all, List<Destination> favs) {
    print("Using Fallback Recommendation System");
    
    // Collect all favorite tags
    Set<String> favTags = {};
    for (var f in favs) {
      favTags.addAll(f.tags);
    }

    List<MapEntry<Destination, int>> scores = [];
    for (var dest in all) {
      if (favs.any((f) => f.id == dest.id)) continue;
      
      int matchCount = 0;
      for (var tag in dest.tags) {
        if (favTags.contains(tag)) matchCount++;
      }
      scores.add(MapEntry(dest, matchCount));
    }

    scores.sort((a, b) => b.value.compareTo(a.value));
    return scores.map((e) => e.key).toList();
  }
}
