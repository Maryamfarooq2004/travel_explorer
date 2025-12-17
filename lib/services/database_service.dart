import 'package:firebase_database/firebase_database.dart';
import '../models/destination.dart';
import '../models/hotel.dart';
import '../models/restaurant.dart';
import '../models/city.dart';
import '../models/review.dart';

class DatabaseService {
  final DatabaseReference _db = FirebaseDatabase.instance.ref();

  // --- Destinations ---
  
  Stream<List<Destination>> getDestinations() {
    return _db.child('destinations').onValue.map((event) {
      final data = event.snapshot.value;
      if (data == null) return [];
      
      try {
        if (data is List) {
           return data.where((e) => e != null).map((e) => Destination.fromMap(e as Map)).toList();
        } else if (data is Map) {
           return data.values.map((e) => Destination.fromMap(e as Map)).toList();
        }
      } catch (e) {
        print("Error parsing destinations: $e");
      }
      return [];
    });
  }

  // --- Hotels ---
  Stream<List<Hotel>> getHotels() {
    return _db.child('hotels').onValue.map((event) {
      final data = event.snapshot.value;
      if (data == null) return [];
      try {
        if (data is List) {
           return data.where((e) => e != null).map((e) => Hotel.fromMap(e as Map)).toList();
        } else if (data is Map) {
           return data.values.map((e) => Hotel.fromMap(e as Map)).toList();
        }
      } catch (e) {
        print("Error parsing hotels: $e");
      }
      return [];
    });
  }

  // --- Restaurants ---
  Stream<List<Restaurant>> getRestaurants() {
    return _db.child('restaurants').onValue.map((event) {
      final data = event.snapshot.value;
      if (data == null) return [];
      try {
        if (data is List) {
           return data.where((e) => e != null).map((e) => Restaurant.fromMap(e as Map)).toList();
        } else if (data is Map) {
           return data.values.map((e) => Restaurant.fromMap(e as Map)).toList();
        }
      } catch (e) {
        print("Error parsing restaurants: $e");
      }
      return [];
    });
  }

  // --- Cities ---
  Stream<List<City>> getCities() {
    return _db.child('cities').onValue.map((event) {
      final data = event.snapshot.value;
      if (data == null) return [];
      try {
        if (data is List) {
           return data.where((e) => e != null).map((e) => City.fromMap(e as Map)).toList();
        } else if (data is Map) {
           return data.values.map((e) => City.fromMap(e as Map)).toList();
        }
      } catch (e) {
        print("Error parsing cities: $e");
      }
      return [];
    });
  }

  // --- Reviews ---
  Stream<List<Review>> getReviews(String destinationId) {
    return _db.child('reviews').orderByChild('destinationId').equalTo(destinationId).onValue.map((event) {
      final data = event.snapshot.value;
      if (data == null) return [];
      try {
        if (data is Map) {
           return data.values.map((e) => Review.fromMap(e as Map)).toList()..sort((a,b) => b.date.compareTo(a.date));
        }
      } catch (e) {
        print("Error parsing reviews: $e");
      }
      return [];
    });
  }

  Future<void> addReview(Review review) async {
    await _db.child('reviews').push().set(review.toJson());
  }

  // --- Seeding ---
  Future<void> seedAllData({
    required List<Destination> destinations,
    required List<Hotel> hotels,
    required List<Restaurant> restaurants,
    List<City>? cities,
  }) async {
    final Map<String, dynamic> updates = {};
    
    for (var dest in destinations) {
      updates['destinations/${dest.id}'] = dest.toJson();
    }
    for (var hotel in hotels) {
      updates['hotels/${hotel.id}'] = hotel.toJson();
    }
    for (var rest in restaurants) {
      updates['restaurants/${rest.id}'] = rest.toJson();
    }
    if (cities != null) {
      for (var city in cities) {
        updates['cities/${city.id}'] = city.toJson();
      }
    }
    
    await _db.update(updates);
  }

  // --- Favorites ---
  Future<void> toggleFavorite(String uid, String destinationId, bool currentStatus) async {
    if (currentStatus) {
      // Remove
      await _db.child('users/$uid/favorites/$destinationId').remove();
    } else {
      // Add
      await _db.child('users/$uid/favorites/$destinationId').set(true);
    }
  }

  // --- User Profile ---
  Stream<Map<String, dynamic>> getUserProfile(String uid) {
    return _db.child('users/$uid/profile').onValue.map((event) {
      final data = event.snapshot.value;
      if (data != null && data is Map) {
        return Map<String, dynamic>.from(data);
      }
      return {};
    });
  }

  Future<void> updateUserProfile(String uid, Map<String, dynamic> data) async {
    await _db.child('users/$uid/profile').update(data);
  }

  Stream<List<String>> getFavoriteIds(String uid) {
    return _db.child('users/$uid/favorites').onValue.map((event) {
      final data = event.snapshot.value;
      if (data == null) return [];
      if (data is Map) {
        return data.keys.map((k) => k.toString()).toList();
      }
      return [];
    });
  }
}
