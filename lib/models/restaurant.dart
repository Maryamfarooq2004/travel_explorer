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
}
