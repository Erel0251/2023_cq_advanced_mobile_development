import 'package:let_tutor_app/models/tutor/account_info.dart';

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
