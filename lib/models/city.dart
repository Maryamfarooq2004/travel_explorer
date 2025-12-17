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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'province': province,
      'description': description,
      'imageUrl': imageUrl,
      'destinationIds': destinationIds,
    };
  }

  factory City.fromMap(Map<dynamic, dynamic> map) {
    return City(
      id: map['id']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      province: map['province']?.toString() ?? '',
      description: map['description']?.toString() ?? '',
      imageUrl: map['imageUrl']?.toString() ?? '',
      destinationIds: map['destinationIds'] != null 
          ? List<String>.from((map['destinationIds'] as List).map((e) => e.toString())) 
          : [],
    );
  }
}
