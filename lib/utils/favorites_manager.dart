import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/destination.dart';
import '../models/review.dart';

/// Manages favorites using SharedPreferences
class FavoritesManager {
  static const String _favoritesKey = 'favorites';
  static const String _reviewsKey = 'reviews';

  /// Add a destination to favorites
  static Future<void> addFavorite(Destination destination) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = await getFavorites();
    
    // Check if already exists
    if (!favorites.any((d) => d.id == destination.id)) {
      favorites.add(destination);
      final favoritesJson = favorites.map((d) => json.encode(d.toJson())).toList();
      await prefs.setStringList(_favoritesKey, favoritesJson);
    }
  }

  /// Remove a destination from favorites
  static Future<void> removeFavorite(String destinationId) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = await getFavorites();
    
    favorites.removeWhere((d) => d.id == destinationId);
    final favoritesJson = favorites.map((d) => json.encode(d.toJson())).toList();
    await prefs.setStringList(_favoritesKey, favoritesJson);
  }

  /// Get all favorite destinations
  static Future<List<Destination>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesJson = prefs.getStringList(_favoritesKey) ?? [];
    
    return favoritesJson.map((jsonStr) {
      final jsonMap = json.decode(jsonStr) as Map<String, dynamic>;
      return Destination.fromJson(jsonMap);
    }).toList();
  }

  /// Check if a destination is in favorites
  static Future<bool> isFavorite(String destinationId) async {
    final favorites = await getFavorites();
    return favorites.any((d) => d.id == destinationId);
  }

  /// Add a review
  static Future<void> addReview(Review review) async {
    final prefs = await SharedPreferences.getInstance();
    final reviews = await getReviews();
    
    reviews.add(review);
    final reviewsJson = reviews.map((r) => json.encode(r.toJson())).toList();
    await prefs.setStringList(_reviewsKey, reviewsJson);
  }

  /// Get all reviews for a destination
  static Future<List<Review>> getReviewsForDestination(String destinationId) async {
    final reviews = await getReviews();
    return reviews.where((r) => r.destinationId == destinationId).toList();
  }

  /// Get all reviews
  static Future<List<Review>> getReviews() async {
    final prefs = await SharedPreferences.getInstance();
    final reviewsJson = prefs.getStringList(_reviewsKey) ?? [];
    
    return reviewsJson.map((jsonStr) {
      final jsonMap = json.decode(jsonStr) as Map<String, dynamic>;
      return Review.fromJson(jsonMap);
    }).toList();
  }
}
