/// Model class for travel destinations in Pakistan
class Destination {
  final String id;
  final String name;
  final String location;
  final String description;
  final String imageUrl;
  final String category;
  final double rating;
  final List<String> tags;
  final List<String> hotels;
  final List<String> restaurants;

  Destination({
    required this.id,
    required this.name,
    required this.location,
    required this.description,
    required this.imageUrl,
    required this.category,
    required this.rating,
    required this.tags,
    this.hotels = const [],
    this.restaurants = const [],
  });

  // Convert to JSON for SharedPreferences storage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'description': description,
      'imageUrl': imageUrl,
      'category': category,
      'rating': rating,
      'tags': tags,
      'hotels': hotels,
      'restaurants': restaurants,
    };
  }


  // Create from JSON/Map
  factory Destination.fromMap(Map<dynamic, dynamic> map) {
    return Destination(
      id: map['id']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      location: map['location']?.toString() ?? '',
      description: map['description']?.toString() ?? '',
      imageUrl: map['imageUrl']?.toString() ?? '',
      category: map['category']?.toString() ?? '',
      rating: (map['rating'] is int) 
          ? (map['rating'] as int).toDouble() 
          : (map['rating']?.toDouble() ?? 0.0),
      tags: map['tags'] != null
          ? List<String>.from((map['tags'] as List).map((e) => e.toString()))
          : [],
      hotels: map['hotels'] != null 
          ? List<String>.from((map['hotels'] as List).map((e) => e.toString())) 
          : [],
      restaurants: map['restaurants'] != null 
          ? List<String>.from((map['restaurants'] as List).map((e) => e.toString())) 
          : [],
    );
  }

  factory Destination.fromJson(Map<String, dynamic> json) => Destination.fromMap(json);
}
