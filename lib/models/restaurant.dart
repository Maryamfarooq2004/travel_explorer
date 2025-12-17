/// Model class for restaurants
class Restaurant {
  final String id;
  final String name;
  final String location;
  final double rating;
  final String imageUrl;
  final String cuisine;
  final String priceRange;

  Restaurant({
    required this.id,
    required this.name,
    required this.location,
    required this.rating,
    required this.imageUrl,
    required this.cuisine,
    required this.priceRange,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'rating': rating,
      'imageUrl': imageUrl,
      'cuisine': cuisine,
      'priceRange': priceRange,
    };
  }

  factory Restaurant.fromMap(Map<dynamic, dynamic> map) {
    return Restaurant(
      id: map['id']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      location: map['location']?.toString() ?? '',
      rating: (map['rating'] is int) 
          ? (map['rating'] as int).toDouble() 
          : (map['rating']?.toDouble() ?? 0.0),
      imageUrl: map['imageUrl']?.toString() ?? '',
      cuisine: map['cuisine']?.toString() ?? '',
      priceRange: map['priceRange']?.toString() ?? '',
    );
  }
}
