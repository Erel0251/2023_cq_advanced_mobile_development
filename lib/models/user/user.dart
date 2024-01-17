import 'dart:convert';
import 'dart:ffi';

import 'package:let_tutor_app/models/authentication/wallet_info.dart';
import 'package:let_tutor_app/models/tutor/account_info.dart';

class User {
  final String id;
  final String name;
  final String? email;
  final String? avatar;
  final String? country;
  final String? phone;
  final String? language;
  final List<String> roles;
  final String birthday;
  final bool? isActivated;
  final TutorInfo? tutorInfo;
  final Wallet? walletInfo;
  final String? requireNote;
  final String? level;
  final List<Map<String, dynamic>>? learnTopics;
  final List<String>? testPreparations;
  final bool? isPhoneActivated;
  final int? timezone;
  final dynamic referralInfo;
  final String? studySchedule;
  final bool? canSendMessage;
  final dynamic studentGroup;
  final dynamic studentInfo;
  final Float? avgRating;

  const User({
    required this.id,
    required this.name,
    this.email,
    this.avatar,
    this.country,
    this.phone,
    this.language,
    required this.roles,
    required this.birthday,
    this.isActivated,
    this.tutorInfo,
    this.walletInfo,
    this.requireNote,
    this.level,
    this.learnTopics,
    this.testPreparations,
    this.isPhoneActivated,
    this.timezone,
    this.referralInfo,
    this.studySchedule,
    this.canSendMessage,
    this.studentGroup,
    this.studentInfo,
    this.avgRating,
  });

  String toJson() {
    return jsonEncode(<String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'avatar': avatar,
      'country': country,
      'phone': phone,
      'language': language,
      'roles': roles,
      'birthday': birthday,
      'isActivated': isActivated,
      'tutorInfo': tutorInfo,
      'walletInfo': walletInfo,
      'requireNote': requireNote,
      'level': level,
      'learnTopics': learnTopics,
      'testPreparations': testPreparations,
      'isPhoneActivated': isPhoneActivated,
      'timezone': timezone,
      'referralInfo': referralInfo,
      'studySchedule': studySchedule,
      'canSendMessage': canSendMessage,
      'studentGroup': studentGroup,
      'studentInfo': studentInfo,
      'avgRating': avgRating,
    });
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      avatar: json['avatar'],
      country: json['country'],
      phone: json['phone'],
      language: json['language'],
      roles: json['roles'].cast<String>(),
      birthday: json['birthday'],
      isActivated: json['isActivated'],
      tutorInfo: json['tutorInfo'] != null
          ? TutorInfo.fromJson(json['tutorInfo'])
          : null,
      walletInfo: json['walletInfo'] != null
          ? Wallet.fromJson(json['walletInfo'])
          : null,
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
      referralInfo: json['referralInfo'],
      studySchedule: json['studySchedule'],
      canSendMessage: json['canSendMessage'],
      studentGroup: json['studentGroup'],
      studentInfo: json['studentInfo'],
      avgRating: json['avgRating'],
    );
  }
}
