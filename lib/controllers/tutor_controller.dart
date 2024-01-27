import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:let_tutor_app/models/tutor/response_search.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:let_tutor_app/models/course/feedback.dart';
import 'package:let_tutor_app/models/tutor/account_info.dart';
import 'package:let_tutor_app/models/tutor/response_tutors.dart';

Future<TutorInfo> fetchTutorById(String id) async {
  final String baseUrl = dotenv.env['BASE_URL'] ?? '';
  final prefs = await SharedPreferences.getInstance();
  final String token = prefs.getString('token') ?? '';

  final response = await http.get(
    Uri.parse('${baseUrl}tutor/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    final TutorInfo responseTutors =
        TutorInfo.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    return responseTutors;
  } else {
    throw Exception('Failed to load tutor information');
  }
}

Future<ResponseTutors> fetchTutorsInfo({
  int page = 1,
  int size = 10,
}) async {
  final String baseUrl = dotenv.env['BASE_URL'] ?? '';
  final prefs = await SharedPreferences.getInstance();
  final String token = prefs.getString('token') ?? '';

  String queryPage = '&page=$page';
  String querySize = '&perPage=$size';
  final response = await http.get(
    Uri.parse('${baseUrl}tutor/more?$queryPage$querySize'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    final ResponseTutors responseTutors = ResponseTutors.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
    return responseTutors;
  } else {
    throw Exception('Failed to load tutors');
  }
}

Future<ResponseSearchTutor> searchTutorsInfo({
  int page = 1,
  int perPage = 10,
  String search = '',
  List<String> nationality = const [],
  String specialties = '',
}) async {
  final String baseUrl = dotenv.env['BASE_URL'] ?? '';
  final prefs = await SharedPreferences.getInstance();
  final String token = prefs.getString('token') ?? '';

  bool? isVietnamese;
  bool? isNative;
  if (nationality.length < 3 && nationality.isNotEmpty) {
    if (nationality.contains('Foreign tutor')) {
      if (nationality.contains('Vietnamese tutor')) {
        isNative = false;
      }
      if (nationality.contains('Native English tutor')) {
        isVietnamese = false;
      }
    } else {
      if (nationality.contains('Vietnamese tutor')) {
        isVietnamese = true;
      }
      if (nationality.contains('Native English tutor')) {
        isNative = true;
      }
    }
  }

  RequestBody body = RequestBody(
    page: page,
    perPage: perPage,
    search: search,
    nationality: Nationality(
      isNative: isNative,
      isVietnamese: isVietnamese,
    ),
    specialties: [specialties],
  );

  final response = await http.post(
    Uri.parse('${baseUrl}tutor/search'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(body.toJson()),
  );

  if (response.statusCode == 200) {
    final ResponseSearchTutor responseTutors = ResponseSearchTutor.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
    return responseTutors;
  } else {
    throw Exception('Failed to load tutors');
  }
}

Future<void> addTutorToFavorite(String id) async {
  final String baseUrl = dotenv.env['BASE_URL'] ?? '';
  final prefs = await SharedPreferences.getInstance();
  final String token = prefs.getString('token') ?? '';

  final response = await http.post(
    Uri.parse('${baseUrl}user/manageFavoriteTutor'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(<String, String>{
      'tutorId': id,
    }),
  );

  if (response.statusCode == 200) {
    return;
  } else {
    throw Exception('Failed to add tutor to favorite');
  }
}

Future<void> addFeedback(ContentFeedback feedback) async {
  final String baseUrl = dotenv.env['BASE_URL'] ?? '';
  final prefs = await SharedPreferences.getInstance();
  final String token = prefs.getString('token') ?? '';

  final response = await http.post(
    Uri.parse('${baseUrl}user/feedback'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: feedback.toJson(),
  );

  if (response.statusCode == 200) {
    return;
  } else {
    throw Exception('Failed to add feedback');
  }
}
