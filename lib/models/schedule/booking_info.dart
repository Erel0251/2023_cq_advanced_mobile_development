import 'package:let_tutor_app/models/course/feedback.dart';
import 'package:let_tutor_app/models/schedule/schedule_detail.dart';
import 'package:let_tutor_app/models/tutor/account_info.dart';

class BookingInfo {
  final int createdAtTimeStamp;
  final int updatedAtTimeStamp;
  final String id;
  final String userId;
  final String? scheduleDetailId;
  final String? tutorMeetingLink;
  final String? studentMeetingLink;
  final String? googleMeetLink;
  final String? studentRequest;
  final String? tutorReview;
  final int? scoreByTutor;
  final String createdAt;
  final String updatedAt;
  final String? recordUrl;
  final int? cancelReasonId;
  final int? lessonPlanId;
  final String? cancelNote;
  final String? calendarId;
  final bool? isDeleted;
  final bool? isTrial;
  final int? convertedLesson;
  final ScheduleDetail? scheduleDetailInfo;
  final Map<String, dynamic>? classReview;
  final List<ContentFeedback>? feedbacks;
  final bool? showRecordUrl;

  const BookingInfo({
    required this.createdAtTimeStamp,
    required this.updatedAtTimeStamp,
    required this.id,
    required this.userId,
    this.scheduleDetailId,
    this.tutorMeetingLink,
    this.studentMeetingLink,
    this.googleMeetLink,
    this.studentRequest,
    this.tutorReview,
    this.scoreByTutor,
    required this.createdAt,
    required this.updatedAt,
    this.recordUrl,
    this.cancelReasonId,
    this.lessonPlanId,
    this.cancelNote,
    this.calendarId,
    this.isDeleted,
    this.isTrial,
    this.scheduleDetailInfo,
    this.convertedLesson,
    this.classReview,
    this.feedbacks,
    this.showRecordUrl,
  });

  factory BookingInfo.fromJson(Map<String, dynamic> json) {
    return BookingInfo(
      createdAtTimeStamp: json['createdAtTimeStamp'],
      updatedAtTimeStamp: json['updatedAtTimeStamp'],
      id: json['id'],
      userId: json['userId'],
      scheduleDetailId: json['scheduleDetailId'],
      tutorMeetingLink: json['tutorMeetingLink'],
      studentMeetingLink: json['studentMeetingLink'],
      googleMeetLink: json['googleMeetLink'],
      studentRequest: json['studentRequest'],
      tutorReview: json['tutorReview'],
      scoreByTutor: json['scoreByTutor'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      recordUrl: json['recordUrl'],
      cancelReasonId: json['cancelReasonId'],
      lessonPlanId: json['lessonPlanId'],
      cancelNote: json['cancelNote'],
      calendarId: json['calendarId'],
      isDeleted: json['isDeleted'],
      isTrial: json['isTrial'],
      convertedLesson: json['convertedLesson'],
      scheduleDetailInfo: json['scheduleDetailInfo'] != null
          ? ScheduleDetail.fromJson(json['scheduleDetailInfo'])
          : null,
      classReview: json['classReview'],
      feedbacks: json['feedbacks'] != null
          ? (json['feedbacks'] as List)
              .map((e) => ContentFeedback.fromJson(e))
              .toList()
          : null,
      showRecordUrl: json['showRecordUrl'],
    );
  }

  TutorInfo getTutor() {
    return scheduleDetailInfo!.scheduleInfo!.tutorInfo!;
  }
}
