import 'package:let_tutor_app/models/authentication/tokens.dart';
import 'package:let_tutor_app/models/authentication/wallet_info.dart';

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

class User {
  final String id;
  final String email;
  final String name;
  final String? avatar;
  final String? country;
  final String? phone;
  final List<String>? roles;
  final String? language;
  final String? birthday;
  final bool? isActivated;
  final Wallet walletInfo;
  final List<String>? courses;
  final String? requireNote;
  final String? level;
  final List<Map<String, dynamic>>? learnTopics;
  final List<String>? testPreparations;
  final bool? isPhoneActivated;
  final int? timezone;
  final String? studySchedule;
  final bool? canSendMessage;

  const User({
    required this.id,
    required this.email,
    required this.name,
    this.avatar,
    this.country,
    this.phone,
    this.roles,
    this.language,
    this.birthday,
    this.isActivated,
    required this.walletInfo,
    this.courses,
    this.requireNote,
    this.level,
    this.learnTopics,
    this.testPreparations,
    this.isPhoneActivated,
    this.timezone,
    this.studySchedule,
    this.canSendMessage,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      avatar: json['avatar'],
      country: json['country'],
      phone: json['phone'],
      roles: json['roles'] != null ? List<String>.from(json['roles']) : null,
      language: json['language'],
      birthday: json['birthday'],
      isActivated: json['isActivated'],
      walletInfo: Wallet.fromJson(json['walletInfo']),
      courses:
          json['courses'] != null ? List<String>.from(json['courses']) : null,
      requireNote: json['requireNote'],
      level: json['level'],
      learnTopics: json['learnTopics'] != null
          ? List<Map<String, dynamic>>.from(json['learnTopics'])
          : null,
      testPreparations: json['testPreparations'] != null
          ? List<String>.from(json['testPreparations'])
          : null,
      isPhoneActivated: json['isPhoneActivated'],
      timezone: json['timezone'],
      studySchedule: json['studySchedule'],
      canSendMessage: json['canSendMessage'],
    );
  }
}
