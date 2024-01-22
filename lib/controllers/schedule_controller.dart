import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:let_tutor_app/models/schedule/response_schedule.dart';
import 'package:let_tutor_app/models/schedule/booking_info.dart';
import 'package:let_tutor_app/models/schedule/response_booked.dart';

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

Future<List<BookingInfo>> getBookedClass() async {
  final String baseUrl = dotenv.env['BASE_URL'] ?? '';
  final prefs = await SharedPreferences.getInstance();
  final String token = prefs.getString('token') ?? '';

  final response = await http.get(
    Uri.parse('${baseUrl}booking/list/student?orderBy=meeting&sortBy=desc'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    final ResponseBooked responseBooked =
        ResponseBooked.fromJson(jsonDecode(response.body));
    return responseBooked.data.rows;
  } else {
    throw Exception('Failed to load booked class information');
  }
}

Future<ListBooked> getFutureBookedClass(
    {int page = 1, int perPage = 20}) async {
  final String baseUrl = dotenv.env['BASE_URL'] ?? '';
  final prefs = await SharedPreferences.getInstance();
  final String token = prefs.getString('token') ?? '';

  final response = await http.get(
    Uri.parse(
        '${baseUrl}booking/list/student?page=$page&perPage=$perPage&inFuture=1&orderBy=meeting&sortBy=asc'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    final ResponseBooked responseBooked =
        ResponseBooked.fromJson(jsonDecode(response.body));
    return responseBooked.data;
  } else {
    throw Exception('Failed to load booked class information');
  }
}

Future<ListBooked> getHistoryBookedClass(
    {int page = 1, int perPage = 20}) async {
  final String baseUrl = dotenv.env['BASE_URL'] ?? '';
  final prefs = await SharedPreferences.getInstance();
  final String token = prefs.getString('token') ?? '';

  // get current utc time minus 35 minutes in milliseconds
  final int currentTime = DateTime.now().millisecondsSinceEpoch - 2100000;

  final response = await http.get(
    Uri.parse(
        '${baseUrl}booking/list/student?page=$page&perPage=$perPage&dateTimeLte=$currentTime&orderBy=meeting&sortBy=desc'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    final ResponseBooked responseBooked =
        ResponseBooked.fromJson(jsonDecode(response.body));
    return responseBooked.data;
  } else {
    throw Exception('Failed to load booked class information');
  }
}
