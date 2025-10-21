/// Model class for travel destinations in Pakistan
class Destination {
  final String id;
  final String name;
  final String location;
  final String description;
  final String imageUrl;
  final String category;
  final double rating;
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
      'hotels': hotels,
      'restaurants': restaurants,
    };
  }

  // Create from JSON
  factory Destination.fromJson(Map<String, dynamic> json) {
    return Destination(
      id: json['id'],
      name: json['name'],
      location: json['location'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      category: json['category'],
      rating: json['rating'].toDouble(),
      hotels: List<String>.from(json['hotels'] ?? []),
      restaurants: List<String>.from(json['restaurants'] ?? []),
    );
  }
}
