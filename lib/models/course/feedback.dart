import 'dart:convert';

class ContentFeedback {
  final String? bookingId;
  final String? userId;
  final int? rating;
  final String? content;

  ContentFeedback({
    this.bookingId,
    this.userId,
    this.rating,
    this.content,
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
      bookingId: json['bookingId'],
      userId: json['userId'],
      rating: json['rating'],
      content: json['content'],
    );
  }
}
