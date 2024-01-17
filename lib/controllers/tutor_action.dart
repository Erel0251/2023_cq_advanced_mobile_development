import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:let_tutor_app/models/tutor/account_info.dart';
import 'package:let_tutor_app/models/tutor/response_tutors.dart';

Future<AccountInfo> fetchTutorById(String id) async {
  final String baseUrl = dotenv.env['BASE_URL'] ?? '';
  final String token = dotenv.env['AUTH_TOKEN'] ?? '';

  final response = await http.get(
    Uri.parse('${baseUrl}tutor/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    final AccountInfo responseTutors =
        AccountInfo.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    return responseTutors;
  } else {
    throw Exception('Failed to load tutor information');
  }
}

Future<ResponseTutors> fetchTutorsInfo() async {
  final String baseUrl = dotenv.env['BASE_URL'] ?? '';
  final String token = dotenv.env['AUTH_TOKEN'] ?? '';

  final response = await http.get(
    Uri.parse('${baseUrl}tutor/more?perPage=9&page=1'),
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
