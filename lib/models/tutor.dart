class ResponseTutors {
  final Tutors tutors;
  final List<dynamic>? favoriteTutors;

  const ResponseTutors({
    required this.tutors,
    this.favoriteTutors,
  });

  factory ResponseTutors.fromJson(Map<String, dynamic> json) {
    return ResponseTutors(
      tutors: Tutors.fromJson(json['tutors']),
      favoriteTutors:
          json['favoriteTutor']?.map((e) => FavoriteTutor.fromJson(e)).toList(),
    );
  }
}

class Tutors {
  final int count;
  final List<dynamic> row;

  const Tutors({
    required this.count,
    required this.row,
  });

  factory Tutors.fromJson(Map<String, dynamic> json) {
    return Tutors(
      count: json['count'],
      row: json['rows'] != null
          ? json['rows'].map((e) => AccountInfo.fromJson(e)).toList()
          : [],
    );
  }
}

class FavoriteTutor {
  final String id;
  final String firstId;
  final String secondId;
  final String createdAt;
  final String updatedAt;
  final AccountInfo? secondInfo;

  const FavoriteTutor({
    required this.id,
    required this.firstId,
    required this.secondId,
    required this.createdAt,
    required this.updatedAt,
    this.secondInfo,
  });

  factory FavoriteTutor.fromJson(Map<String, dynamic> json) {
    return FavoriteTutor(
      id: json['id'],
      firstId: json['firstId'],
      secondId: json['secondId'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      secondInfo: json['secondInfo'] != null
          ? AccountInfo.fromJson(json['secondInfo'])
          : null,
    );
  }
}

class Feedback {
  final String id;
  final String? bookingId;
  final String? firstId;
  final String? secondId;
  final int? rating;
  final String? content;
  final String? createdAt;
  final String? updatedAt;
  final AccountInfo? firstInfo;

  const Feedback({
    required this.id,
    this.bookingId,
    this.firstId,
    this.secondId,
    this.rating,
    this.content,
    this.createdAt,
    this.updatedAt,
    this.firstInfo,
  });

  factory Feedback.fromJson(Map<String, dynamic> json) {
    return Feedback(
      id: json['id'],
      bookingId: json['bookingId'],
      firstId: json['firstId'],
      secondId: json['secondId'],
      rating: json['rating'],
      content: json['content'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      firstInfo: json['firstInfo'] != null
          ? AccountInfo.fromJson(json['firstInfo'])
          : null,
    );
  }
}

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
      feedbacks: json['feedbacks'] != null
          ? json['feedbacks'].map((e) => Feedback.fromJson(e)).toList()
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

class Course {
  final String id;
  final String name;
  final TutorCourse? tutorCourse;

  const Course({
    required this.id,
    required this.name,
    this.tutorCourse,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      name: json['name'],
      tutorCourse: json['TutorCourse'] != null
          ? TutorCourse.fromJson(json['TutorCourse'])
          : null,
    );
  }
}

class TutorCourse {
  final String userId;
  final String courseId;
  final String createdAt;
  final String updatedAt;

  const TutorCourse({
    required this.userId,
    required this.courseId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TutorCourse.fromJson(Map<String, dynamic> json) {
    return TutorCourse(
      userId: json['UserId'],
      courseId: json['CourseId'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
