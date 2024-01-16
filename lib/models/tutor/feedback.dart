import 'package:test_route/models/tutor/account_info.dart';

class FeedbackTutor {
  final String id;
  final String? bookingId;
  final String? firstId;
  final String? secondId;
  final int? rating;
  final String? content;
  final String? createdAt;
  final String? updatedAt;
  final AccountInfo? firstInfo;

  const FeedbackTutor({
    required this.id,
    this.bookingId,
    this.firstId,
    this.secondId,
    this.rating,
    this.content,
    this.createdAt,
    this.updatedAt,
    this.firstInfo,
  });

  factory FeedbackTutor.fromJson(Map<String, dynamic> json) {
    return FeedbackTutor(
      id: json['id'],
      bookingId: json['bookingId'],
      firstId: json['firstId'],
      secondId: json['secondId'],
      rating: json['rating'],
      content: json['content'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      firstInfo: json['firstInfo'] != null
          ? AccountInfo.fromJson(json['firstInfo'])
          : null,
    );
  }
}
