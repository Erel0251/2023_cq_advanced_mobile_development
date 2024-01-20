import 'package:let_tutor_app/models/schedule/schedule_detail.dart';
import 'package:let_tutor_app/models/tutor/account_info.dart';

class Schedule {
  final String id;
  final String tutorId;
  final String startTime;
  final String endTime;
  final int startTimeStamp;
  final int endTimeStamp;
  final String createdAt;
  final bool? isBooked;
  final List<ScheduleDetail>? scheduleDetails;
  final TutorInfo? tutorInfo;
  final String? date;
  final bool? isDeleted;

  const Schedule({
    required this.id,
    required this.tutorId,
    required this.startTime,
    required this.endTime,
    required this.startTimeStamp,
    required this.endTimeStamp,
    required this.createdAt,
    this.isBooked,
    this.isDeleted,
    this.scheduleDetails,
    this.tutorInfo,
    this.date,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      id: json['id'],
      tutorId: json['tutorId'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      startTimeStamp: json['startTimestamp'],
      endTimeStamp: json['endTimestamp'],
      createdAt: json['createdAt'],
      isBooked: json['isBooked'],
      scheduleDetails: json['scheduleDetails'] != null
          ? List<ScheduleDetail>.from(
              json['scheduleDetails'].map(
                (scheduleDetail) => ScheduleDetail.fromJson(scheduleDetail),
              ),
            )
          : null,
      tutorInfo: json['tutorInfo'] != null
          ? TutorInfo.fromJson(json['tutorInfo'])
          : null,
      date: json['date'],
    );
  }
}
