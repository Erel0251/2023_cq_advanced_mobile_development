import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:let_tutor_app/models/schedule/response_schedule.dart';

Future<ResponseSchedule> getSchedule() async {
  final String baseUrl = dotenv.env['BASE_URL'] ?? '';
  final prefs = await SharedPreferences.getInstance();
  final String token = prefs.getString('token') ?? '';

  final response = await http.post(
    Uri.parse('${baseUrl}schedule'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    final ResponseSchedule responseSchedule = ResponseSchedule.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
    return responseSchedule;
  } else {
    throw Exception('Failed to load schedule information');
  }
}

Future<ResponseSchedule> getScheduleByTutorId(String id) async {
  final String baseUrl = dotenv.env['BASE_URL'] ?? '';
  final prefs = await SharedPreferences.getInstance();
  final String token = prefs.getString('token') ?? '';

  final response = await http.post(
    Uri.parse('${baseUrl}schedule'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(
      <String, String>{
        'tutorId': id,
      },
    ),
  );

  if (response.statusCode == 200) {
    final ResponseSchedule responseSchedule = ResponseSchedule.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
    return responseSchedule;
  } else {
    throw Exception('Failed to load schedule information');
  }
}
