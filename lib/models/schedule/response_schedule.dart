import 'package:let_tutor_app/models/schedule/schedule.dart';

class ResponseSchedule {
  final String message;
  final List<Schedule> data;

  const ResponseSchedule({
    required this.message,
    required this.data,
  });

  factory ResponseSchedule.fromJson(Map<String, dynamic> json) {
    return ResponseSchedule(
      message: json['message'],
      data: List<Schedule>.from(
        json['data'].map(
          (schedule) => Schedule.fromJson(schedule),
        ),
      ),
    );
  }
}
