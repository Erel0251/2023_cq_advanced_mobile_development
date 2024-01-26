import 'package:let_tutor_app/models/schedule/schedule.dart';

class ResponseSchedule {
  final String message;
  final List<Schedule>? data;
  final List<Schedule>? dataTutor;

  const ResponseSchedule({
    required this.message,
    this.data,
    this.dataTutor,
  });

  factory ResponseSchedule.fromJson(Map<String, dynamic> json) {
    return ResponseSchedule(
      message: json['message'],
      data: json['data'] != null
          ? List<Schedule>.from(
              json['data'].map(
                (schedule) => Schedule.fromJson(schedule),
              ),
            )
          : null,
      dataTutor: json['scheduleOfTutor'] != null
          ? List<Schedule>.from(
              json['scheduleOfTutor'].map(
                (schedule) => Schedule.fromJson(schedule),
              ),
            )
          : null,
    );
  }
}
