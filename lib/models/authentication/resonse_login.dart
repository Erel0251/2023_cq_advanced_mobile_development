import 'package:let_tutor_app/models/authentication/tokens.dart';
import 'package:let_tutor_app/models/authentication/user.dart';

class ResponseLogin {
  final User user;
  final Tokens token;

  const ResponseLogin({
    required this.user,
    required this.token,
  });

  factory ResponseLogin.fromJson(Map<String, dynamic> json) {
    return ResponseLogin(
      user: User.fromJson(json['user']),
      token: Tokens.fromJson(json['tokens']),
    );
  }
}
