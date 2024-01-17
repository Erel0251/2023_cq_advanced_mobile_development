import 'package:let_tutor_app/models/tutor/course.dart';
import 'package:let_tutor_app/models/tutor/feedback.dart';

class AccountInfo {
  final String? id;
  final String? userId;

  // basic info
  final String? name;
  final String? avatar;
  final String? country;
  final String? phone;
  final String? language;
  final String? birthday;

  final String? level;
  final int? timezone;

  // config
  final bool? requestPassword;
  final bool? isActivated;
  final bool? isPhoneActivated;
  final bool? isPhoneAuthActivated;
  final String? requireNote;
  final bool? canSendMessage;
  final bool? isPublicRecord;
  final String? caredByStaffId;
  final String? zaloUserId;
  final bool? isFavorite;

  // account info
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;

  // tutor info
  final String? video;
  final String? bio;
  final String? education;
  final String? experience;
  final String? profession;
  final String? accent;
  final String? targetStudent;
  final String? interests;
  final String? languages;
  final String? specialties;
  final String? resume;
  final double? rating;
  final double? averageRating;
  final bool? isNative;
  final String? youtubeVideoId;
  final int? price;
  final bool? isOnline;
  final String? studentGroupId;
  final List<dynamic>? feedbacks;
  final int? totalFeedbacks;
  final AccountInfo? tutorInfo;
  final AccountInfo? user;
  final List<dynamic>? courses;

  // connection
  final String? email;
  final String? google;
  final String? facebook;
  final String? apple;

  const AccountInfo({
    this.id,
    this.userId,
    this.name,
    this.avatar,
    this.country,
    this.phone,
    this.language,
    this.birthday,
    this.level,
    this.timezone,
    this.requestPassword,
    this.isActivated,
    this.isPhoneActivated,
    this.isPhoneAuthActivated,
    this.requireNote,
    this.canSendMessage,
    this.isPublicRecord,
    this.isFavorite,
    this.caredByStaffId,
    this.zaloUserId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.video,
    this.bio,
    this.education,
    this.experience,
    this.profession,
    this.accent,
    this.targetStudent,
    this.interests,
    this.languages,
    this.specialties,
    this.resume,
    this.rating,
    this.averageRating,
    this.isNative,
    this.youtubeVideoId,
    this.price,
    this.isOnline,
    this.studentGroupId,
    this.totalFeedbacks,
    this.feedbacks,
    this.email,
    this.google,
    this.facebook,
    this.apple,
    this.tutorInfo,
    this.user,
    this.courses,
  });

  // json with format camelCase
  factory AccountInfo.fromJson(Map<String, dynamic> json) {
    return AccountInfo(
      id: json['id'],
      userId: json['userId'],
      name: json['name'],
      avatar: json['avatar'],
      country: json['country'],
      phone: json['phone'],
      language: json['language'],
      birthday: json['birthday'],
      level: json['level'],
      timezone: json['timezone'],
      requestPassword: json['requestPassword'],
      isActivated: json['isActivated'],
      isPhoneActivated: json['isPhoneActivated'],
      isPhoneAuthActivated: json['isPhoneAuthActivated'],
      requireNote: json['requireNote'],
      canSendMessage: json['canSendMessage'],
      isPublicRecord: json['isPublicRecord'],
      caredByStaffId: json['caredByStaffId'],
      isFavorite: json['isFavorite'],
      zaloUserId: json['zaloUserId'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      deletedAt: json['deletedAt'],
      video: json['video'],
      bio: json['bio'],
      education: json['education'],
      experience: json['experience'],
      profession: json['profession'],
      accent: json['accent'],
      targetStudent: json['targetStudent'],
      interests: json['interests'],
      languages: json['languages'],
      specialties: json['specialties'],
      resume: json['resume'],
      rating: json['rating'],
      averageRating: json['avgRating'],
      isNative: json['isNative'],
      youtubeVideoId: json['youtubeVideoId'],
      price: json['price'],
      isOnline: json['isOnline'],
      studentGroupId: json['studentGroupId'],
      totalFeedbacks: json['totalFeedback'],
      courses: json['courses'] != null
          ? json['courses'].map((e) => Course.fromJson(e)).toList()
          : [],
      feedbacks: json['feedbacks'] != null
          ? json['feedbacks'].map((e) => FeedbackTutor.fromJson(e)).toList()
          : [],
      email: json['email'],
      google: json['google'],
      facebook: json['facebook'],
      apple: json['apple'],
      tutorInfo: json['tutorInfo'] != null
          ? AccountInfo.fromJson(json['tutorInfo'])
          : null,
      user: json['User'] != null ? AccountInfo.fromJson(json['User']) : null,
    );
  }
}
