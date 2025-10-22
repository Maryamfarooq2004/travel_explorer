/// Model class for cities
class City {
  final String id;
  final String name;
  final String province;
  final String description;
  final String imageUrl;
  final List<String> destinationIds; // IDs of destinations in this city

  City({
    required this.id,
    required this.name,
    required this.province,
    required this.description,
    required this.imageUrl,
    required this.destinationIds,
  });
}
