import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:let_tutor_app/models/course/course_detail.dart';

import 'package:let_tutor_app/models/course/response_courses.dart';

Future<ListCourses> fetchCourses({
  int page = 1,
  int size = 10,
  String type = 'course',
}) async {
  final String baseUrl = dotenv.env['BASE_URL'] ?? '';
  final String token = dotenv.env['AUTH_TOKEN'] ?? '';

  final response = await http.get(
    Uri.parse('$baseUrl$type?page=$page&size=$size'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    final ResponseCourses responseCourses =
        ResponseCourses.fromJson(jsonDecode(response.body));
    return ListCourses.fromJson(responseCourses.data);
  } else {
    return Future.error('Fetch courses failed');
  }
}

Future<CourseDetailData> fetchCourseById(String id) async {
  final String baseUrl = dotenv.env['BASE_URL'] ?? '';
  final String token = dotenv.env['AUTH_TOKEN'] ?? '';

  final response = await http.get(
    Uri.parse('${baseUrl}course/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    final ResponseCourse courseDetail =
        ResponseCourse.fromJson(jsonDecode(response.body));
    return courseDetail.data;
  } else {
    return Future.error('Fetch course detail failed');
  }
}

// From the list of courses, mapping and filtering the courses by category
Map<String, List<CourseDetailData>> mapCoursesByCategory(
    List<CourseDetailData> courses) {
  final Map<String, List<CourseDetailData>> coursesByCategory = {};

  courses.map((course) {
    course.categories?.map((category) {
      if (coursesByCategory.containsKey(category.title)) {
        coursesByCategory[category.title]?.add(course);
      } else {
        coursesByCategory[category.title] = [course];
      }
    }).toList();
  }).toList();

  return coursesByCategory;
}
