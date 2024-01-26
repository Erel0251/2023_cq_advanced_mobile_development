import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:let_tutor_app/models/authentication/user.dart';

Future<User> getUserInformation() async {
  final String baseUrl = dotenv.env['BASE_URL'] ?? '';
  final prefs = await SharedPreferences.getInstance();
  final String token = prefs.getString('token') ?? '';

  final response = await http.get(
    Uri.parse('{$baseUrl}user/info'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    final User responseUser = User.fromJson(jsonDecode(response.body));
    return responseUser;
  } else {
    return Future.error('Fetch user information failed');
  }
}
