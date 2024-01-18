import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';

import 'package:let_tutor_app/models/user/user.dart';

Future<User> getUserInformation() async {
  final String baseUrl = dotenv.env['BASE_URL'] ?? '';
  final String token = dotenv.env['AUTH_TOKEN'] ?? '';

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
