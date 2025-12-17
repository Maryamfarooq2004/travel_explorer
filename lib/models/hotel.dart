/// Model class for hotels
class Hotel {
  final String id;
  final String name;
  final String location;
  final double rating;
  final String imageUrl;
  final String price;
  final String description;

  Hotel({
    required this.id,
    required this.name,
    required this.location,
    required this.rating,
    required this.imageUrl,
    required this.price,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'rating': rating,
      'imageUrl': imageUrl,
      'price': price,
      'description': description,
    };
  }

  factory Hotel.fromMap(Map<dynamic, dynamic> map) {
    return Hotel(
      id: map['id']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      location: map['location']?.toString() ?? '',
      rating: (map['rating'] is int) 
          ? (map['rating'] as int).toDouble() 
          : (map['rating']?.toDouble() ?? 0.0),
      imageUrl: map['imageUrl']?.toString() ?? '',
      price: map['price']?.toString() ?? '',
      description: map['description']?.toString() ?? '',
    );
  }
}
