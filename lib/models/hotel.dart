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
}
