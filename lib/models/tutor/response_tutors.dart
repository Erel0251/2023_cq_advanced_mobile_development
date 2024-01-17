import 'package:let_tutor_app/models/tutor/favorite_tutor.dart';
import 'package:let_tutor_app/models/tutor/tutor.dart';

class ResponseTutors {
  final Tutors tutors;
  final List<dynamic>? favoriteTutors;

  const ResponseTutors({
    required this.tutors,
    this.favoriteTutors,
  });

  factory ResponseTutors.fromJson(Map<String, dynamic> json) {
    return ResponseTutors(
      tutors: Tutors.fromJson(json['tutors']),
      favoriteTutors:
          json['favoriteTutor']?.map((e) => FavoriteTutor.fromJson(e)).toList(),
    );
  }
}
