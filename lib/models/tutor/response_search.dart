import 'package:let_tutor_app/models/tutor/account_info.dart';

class ResponseSearchTutor {
  int count;
  List<TutorInfo> rows;

  ResponseSearchTutor({
    required this.count,
    required this.rows,
  });

  factory ResponseSearchTutor.fromJson(Map<String, dynamic> json) {
    return ResponseSearchTutor(
      count: json['count'],
      rows: json['rows'] != null
          ? (json['rows'] as List<dynamic>)
              .map((e) => TutorInfo.fromJson(e))
              .toList()
          : [],
    );
  }
}

class RequestBody {
  final int page;
  final int perPage;
  final String search;
  final Nationality nationality;
  final List<String> specialties;

  const RequestBody({
    required this.page,
    required this.perPage,
    required this.search,
    this.nationality = const Nationality(),
    this.specialties = const [],
  });

  toJson() {
    return {
      'page': page,
      'perPage': perPage,
      'search': search,
      'nationality': nationality.toJson(),
      'specialties': specialties,
    };
  }
}

class Nationality {
  final bool? isNative;
  final bool? isVietnamese;

  const Nationality({
    this.isNative,
    this.isVietnamese,
  });

  toJson() {
    return {
      'isNative': isNative,
      'isVietnamese': isVietnamese,
    };
  }
}
