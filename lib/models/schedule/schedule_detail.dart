import 'package:intl/intl.dart';
import 'package:let_tutor_app/models/schedule/booking_info.dart';
import 'package:let_tutor_app/models/schedule/schedule.dart';

class ScheduleDetail {
  final int startPeriodTimestamp;
  final int endPeriodTimestamp;
  final String id;
  final String startPeriod;
  final String endPeriod;
  final String createdAt;
  final String updatedAt;
  final bool? isBooked;
  final List<BookingInfo>? bookingInfos;
  final Schedule? scheduleInfo;

  const ScheduleDetail({
    required this.startPeriodTimestamp,
    required this.endPeriodTimestamp,
    required this.id,
    required this.startPeriod,
    required this.endPeriod,
    required this.createdAt,
    required this.updatedAt,
    this.isBooked,
    this.bookingInfos,
    this.scheduleInfo,
  });

  factory ScheduleDetail.fromJson(Map<String, dynamic> json) {
    return ScheduleDetail(
      startPeriodTimestamp: json['startPeriodTimestamp'],
      endPeriodTimestamp: json['endPeriodTimestamp'],
      id: json['id'],
      startPeriod: json['startPeriod'],
      endPeriod: json['endPeriod'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      isBooked: json['isBooked'],
      bookingInfos: json['bookingInfos'] != null
          ? List<BookingInfo>.from(
              json['bookingInfos'].map(
                (bookingInfo) => BookingInfo.fromJson(bookingInfo),
              ),
            )
          : null,
      scheduleInfo: json['scheduleInfo'] != null
          ? Schedule.fromJson(json['scheduleInfo'])
          : null,
    );
  }

  String getLessonDate() {
    return DateFormat('EEE, dd MMM yy').format(
      DateTime.fromMillisecondsSinceEpoch(
        startPeriodTimestamp,
        isUtc: true,
      ),
    );
  }

  String getLessonRangeDate() {
    int now = DateTime.now().millisecondsSinceEpoch;
    int timeDiff = now - startPeriodTimestamp;
    int hourDiff = timeDiff ~/ (1000 * 60 * 60);
    int dateDiff = hourDiff ~/ 24;
    if (dateDiff <= 0) {
      return '$hourDiff hours ago';
    } else {
      return '$dateDiff days ago';
    }
  }
}
