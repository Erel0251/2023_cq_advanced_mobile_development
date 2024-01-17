import 'dart:convert';

class ContentFeedback {
  final String bookingId;
  final String userId;
  final int rating;
  final String content;

  ContentFeedback({
    required this.bookingId,
    required this.userId,
    required this.rating,
    required this.content,
  });

  String toJson() {
    return jsonEncode(<String, dynamic>{
      'bookingId': bookingId,
      'userId': userId,
      'rating': rating,
      'content': content,
    });
  }

  factory ContentFeedback.fromJson(Map<String, dynamic> json) {
    return ContentFeedback(
      bookingId: json['bookingId'] as String,
      userId: json['userId'] as String,
      rating: json['rating'] as int,
      content: json['content'] as String,
    );
  }
}
