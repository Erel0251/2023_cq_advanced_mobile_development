import 'package:let_tutor_app/models/course/course_detail.dart';

class ResponseCourses {
  final String message;
  final Map<String, dynamic> data;

  const ResponseCourses({
    required this.message,
    required this.data,
  });

  factory ResponseCourses.fromJson(Map<String, dynamic> json) {
    return ResponseCourses(
      message: json['message'],
      data: json['data'],
    );
  }
}

class ListCourses {
  final String count;
  final List<CourseDetailData> rows;

  const ListCourses({
    required this.count,
    required this.rows,
  });

  factory ListCourses.fromJson(Map<String, dynamic> json) {
    return ListCourses(
      count: json['count'],
      rows: List<CourseDetailData>.from(
        json['rows'].map(
          (course) => CourseDetailData.fromJson(course),
        ),
      ),
    );
  }
}
