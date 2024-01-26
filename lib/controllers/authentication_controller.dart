import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';

import 'package:let_tutor_app/models/authentication/resonse_login.dart';
import 'package:let_tutor_app/utils/valid_input.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> storeData(ResponseLogin response) async {
  final prefs = await SharedPreferences.getInstance();

  dotenv.env['REFRESH_TOKEN'] = response.token.refresh.token;
  await prefs.setString('token', response.token.access.token);
  await prefs.setString('name', response.user.name);
  await prefs.setString('avatar', response.user.avatar ?? '');
  await prefs.setString('id', response.user.id);
}

// function login and get response, if success add token to dotenv and return account info
Future<void> loginWithEmail(String email, String password) async {
  if (!validEmail(email) || !validPassword(password)) {
    return Future.error('Invalid email or password');
  }

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
    await storeData(responseLogin);
  } else {
    return Future.error('Login failed: ${response.body}');
  }
}

Future<void> loginWithPhone(String phone, String password) async {
  if (!validPhone(phone) || !validPassword(password)) {
    return Future.error('Invalid phone or password');
  }

  final String baseUrl = dotenv.env['BASE_URL'] ?? '';

  final response = await http.post(
    Uri.parse('${baseUrl}auth/phone-login'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(
      <String, String>{
        'phone': phone,
        'password': password,
      },
    ),
  );

  if (response.statusCode == 200) {
    final ResponseLogin responseLogin =
        ResponseLogin.fromJson(jsonDecode(response.body));
    storeData(responseLogin);
  } else {
    return Future.error('Login failed: ${response.body}');
  }
}

Future<void> loginWithFacebook(String token) async {
  final String baseUrl = dotenv.env['BASE_URL'] ?? '';

  final response = await http.post(
    Uri.parse('${baseUrl}auth/facebook'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(
      <String, String>{
        'access_token': token,
      },
    ),
  );

  if (response.statusCode == 200) {
    final ResponseLogin responseLogin =
        ResponseLogin.fromJson(jsonDecode(response.body));
    await storeData(responseLogin);
  } else {
    return Future.error('Login failed: ${response.body}');
  }
}

Future<void> loginWithGoogle(String token) async {
  final String baseUrl = dotenv.env['BASE_URL'] ?? '';

  final response = await http.post(
    Uri.parse('${baseUrl}auth/google'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(
      <String, String>{
        'access_token': token,
      },
    ),
  );

  if (response.statusCode == 200) {
    final ResponseLogin responseLogin =
        ResponseLogin.fromJson(jsonDecode(response.body));
    await storeData(responseLogin);
  } else {
    return Future.error('Login failed: ${response.body}');
  }
}

Future<void> registerWithEmail(String email, String password) async {
  if (!validEmail(email) || !validPassword(password)) {
    return Future.error('Invalid email or password');
  }

  final String baseUrl = dotenv.env['BASE_URL'] ?? '';

  final response = await http.post(
    Uri.parse('${baseUrl}auth/register'),
    headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
    },
    body: jsonEncode(
      <String, dynamic>{
        'email': email,
        'password': password,
        'source': null,
      },
    ),
  );

  if (response.statusCode == 200) {
    ResponseLogin.fromJson(jsonDecode(response.body));
  } else {
    return Future.error('Register failed: ${response.body}');
  }
}

Future<void> registerWithPhone(String phone, String password) async {
  if (!validPhone(phone) || !validPassword(password)) {
    return Future.error('Invalid phone or password');
  }

  final String baseUrl = dotenv.env['BASE_URL'] ?? '';

  final response = await http.post(
    Uri.parse('${baseUrl}auth/phone-register'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(
      <String, dynamic>{
        'phone': phone,
        'password': password,
        'source': null,
      },
    ),
  );

  if (response.statusCode == 200) {
    ResponseLogin.fromJson(jsonDecode(response.body));
  } else {
    return Future.error('Register failed: ${response.body}');
  }
}
