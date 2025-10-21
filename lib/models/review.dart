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

  // Convert to JSON for local storage
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

  // Create from JSON
  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'],
      userName: json['userName'],
      comment: json['comment'],
      rating: json['rating'].toDouble(),
      date: DateTime.parse(json['date']),
      destinationId: json['destinationId'],
    );
  }
}
