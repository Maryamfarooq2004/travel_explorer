/// Model class for user reviews
class Review {
  final String id;
  final String userName;
  final String comment;
  final double rating;
  final DateTime date;
  final String destinationId;

  Review({
    required this.id,
    required this.userName,
    required this.comment,
    required this.rating,
    required this.date,
    required this.destinationId,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'comment': comment,
      'rating': rating,
      'date': date.toIso8601String(),
      'destinationId': destinationId,
    };
  }

  factory Review.fromMap(Map<dynamic, dynamic> map) {
    return Review(
      id: map['id']?.toString() ?? '',
      userName: map['userName']?.toString() ?? 'Anonymous',
      comment: map['comment']?.toString() ?? '',
      rating: (map['rating'] is int) 
          ? (map['rating'] as int).toDouble() 
          : (map['rating']?.toDouble() ?? 0.0),
      date: map['date'] != null ? DateTime.parse(map['date'].toString()) : DateTime.now(),
      destinationId: map['destinationId']?.toString() ?? '',
    );
  }
  
  factory Review.fromJson(Map<String, dynamic> json) => Review.fromMap(json);
}
