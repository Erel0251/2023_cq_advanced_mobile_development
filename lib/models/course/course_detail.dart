import 'dart:ffi';

import 'package:let_tutor_app/models/course/category.dart';
import 'package:let_tutor_app/models/course/topic.dart';
import 'package:let_tutor_app/models/tutor/account_info.dart';

class ResponseCourse {
  final String messsage;
  final CourseDetailData data;

  const ResponseCourse({
    required this.messsage,
    required this.data,
  });

  factory ResponseCourse.fromJson(Map<String, dynamic> json) {
    return ResponseCourse(
      messsage: json['message'],
      data: CourseDetailData.fromJson(json['data']),
    );
  }
}

class CourseDetailData {
  final String id;
  final String name;
  final String description;
  final String? imageUrl;
  final String? fileUrl;
  final String? level;
  final String? reason;
  final String? purpose;
  final String? otherDetails;
  final int? defaultPrice;
  final int? coursePrice;
  final String? courseType;
  final String? sectionType;
  final bool? visible;
  final String? displayOrder;
  final String? createdAt;
  final String? updatedAt;
  final List<Topic>? topics;
  final List<AccountInfo>? users;
  final List<Category>? categories;

  const CourseDetailData({
    required this.id,
    required this.name,
    required this.description,
    this.imageUrl,
    this.fileUrl,
    this.level,
    this.reason,
    this.purpose,
    this.otherDetails,
    this.defaultPrice,
    this.coursePrice,
    this.courseType,
    this.sectionType,
    this.visible,
    this.displayOrder,
    this.createdAt,
    this.updatedAt,
    this.topics,
    this.users,
    this.categories,
  });

  // this case use snake_case
  factory CourseDetailData.fromJson(Map<String, dynamic> json) {
    return CourseDetailData(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      fileUrl: json['fileUrl'],
      level: json['level'],
      reason: json['reason'],
      purpose: json['purpose'],
      otherDetails: json['other_details'],
      defaultPrice: json['default_price'],
      coursePrice: json['course_price'],
      courseType: json['courseType'],
      sectionType: json['sectionType'],
      visible: json['visible'],
      displayOrder: json['displayOrder'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      topics: json['topics'] != null
          ? List<Topic>.from(json['topics'].map((x) => Topic.fromJson(x)))
          : null,
      users: json['users'] != null
          ? List<AccountInfo>.from(
              json['users'].map((x) => AccountInfo.fromJson(x)))
          : null,
      categories: json['categories'] != null
          ? List<Category>.from(
              json['categories'].map((x) => Category.fromJson(x)))
          : null,
    );
  }
}
