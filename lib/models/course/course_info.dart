import 'package:test_route/models/course/course_detail.dart';

class CourseInfo {
  final String message;
  final Courses data;

  const CourseInfo({
    required this.message,
    required this.data,
  });

  factory CourseInfo.fromJson(Map<String, dynamic> json) {
    return CourseInfo(
      message: json['message'],
      data: Courses.fromJson(json['data']),
    );
  }
}

class Courses {
  final int count;
  final List<CourseDetailData> rows;

  const Courses({
    required this.count,
    required this.rows,
  });

  factory Courses.fromJson(Map<String, dynamic> json) {
    return Courses(
      count: json['count'],
      rows: List<CourseDetailData>.from(
          json['rows'].map((x) => CourseDetailData.fromJson(x))),
    );
  }
}
