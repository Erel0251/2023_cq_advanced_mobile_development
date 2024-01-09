import 'dart:ffi';

import 'package:test_route/models/tutor.dart';

class CourseInfo {
  final String message;
  final Courses data;

  const CourseInfo({
    required this.message,
    required this.data,
  });

  factory CourseInfo.fromJson(Map<String, dynamic> json) {
    return CourseInfo(
      message: json['message'],
      data: Courses.fromJson(json['data']),
    );
  }
}

class Courses {
  final int count;
  final List<CourseDetailData> rows;

  const Courses({
    required this.count,
    required this.rows,
  });

  factory Courses.fromJson(Map<String, dynamic> json) {
    return Courses(
      count: json['count'],
      rows: List<CourseDetailData>.from(
          json['rows'].map((x) => CourseDetailData.fromJson(x))),
    );
  }
}

class CourseDetail {
  final String message;
  final CourseDetailData? data;

  const CourseDetail({
    required this.message,
    this.data,
  });

  factory CourseDetail.fromJson(Map<String, dynamic> json) {
    return CourseDetail(
      message: json['message'],
      data:
          json['data'] != null ? CourseDetailData.fromJson(json['data']) : null,
    );
  }
}

class CourseDetailData {
  final String id;
  final String name;
  final String description;
  final String? imageUrl;
  final String? level;
  final String? reason;
  final String? purpose;
  final String? otherDetails;
  final Float? defaultPrice;
  final Float? coursePrice;
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
          ? List<Topic>.from(json['topic'].map((x) => Topic.fromJson(x)))
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

class Topic {
  final String id;
  final String courseId;
  final int? orderCourse;
  final String? name;
  final String? description;
  final String? createdAt;
  final String? updatedAt;
  final String? videoUrl;
  final String? type;
  final String? numberOfPages;
  final String? beforeTheClassNotes;
  final String? afterTheClassNotes;
  final String? nameFile;

  const Topic({
    required this.id,
    required this.courseId,
    this.orderCourse,
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.videoUrl,
    this.type,
    this.numberOfPages,
    this.beforeTheClassNotes,
    this.afterTheClassNotes,
    this.nameFile,
  });

  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
      id: json['id'],
      courseId: json['courseId'],
      orderCourse: json['orderCourse'],
      name: json['name'],
      description: json['description'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      videoUrl: json['videoUrl'],
      type: json['type'],
      numberOfPages: json['numberOfPages'],
      beforeTheClassNotes: json['beforeTheClassNotes'],
      afterTheClassNotes: json['afterTheClassNotes'],
      nameFile: json['nameFile'],
    );
  }
}

class Category {
  final String id;
  final String title;
  final String key;
  final String? displayOrder;
  final String? createdAt;
  final String? updatedAt;

  const Category({
    required this.id,
    required this.title,
    required this.key,
    this.displayOrder,
    this.createdAt,
    this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      title: json['title'],
      key: json['key'],
      displayOrder: json['displayOrder'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
