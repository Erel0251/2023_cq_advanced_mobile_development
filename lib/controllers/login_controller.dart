import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';

import 'package:let_tutor_app/models/authentication/resonse_login.dart';

// function login and get response, if success add token to dotenv and return account info
Future<User> fetchLogin(String email, String password) async {
  final String baseUrl = dotenv.env['BASE_URL'] ?? '';

  final response = await http.post(
    Uri.parse('${baseUrl}auth/login'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(
      <String, String>{
        'email': email,
        'password': password,
      },
    ),
  );

  if (response.statusCode == 200) {
    final ResponseLogin responseLogin =
        ResponseLogin.fromJson(jsonDecode(response.body));
    dotenv.env['AUTH_TOKEN'] = responseLogin.token.access.token;
    dotenv.env['REFRESH_TOKEN'] = responseLogin.token.refresh.token;
    return responseLogin.user;
  } else {
    return Future.error('Login failed');
  }
}
