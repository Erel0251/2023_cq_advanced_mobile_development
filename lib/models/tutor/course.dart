import 'package:let_tutor_app/models/tutor/summary_course.dart';

class Course {
  final String id;
  final String name;
  final TutorCourse? tutorCourse;

  const Course({
    required this.id,
    required this.name,
    this.tutorCourse,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      name: json['name'],
      tutorCourse: json['TutorCourse'] != null
          ? TutorCourse.fromJson(json['TutorCourse'])
          : null,
    );
  }
}
