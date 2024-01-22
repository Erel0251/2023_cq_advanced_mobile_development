import 'package:let_tutor_app/models/schedule/booking_info.dart';

class ResponseBooked {
  final String message;
  final ListBooked data;

  const ResponseBooked({
    required this.message,
    required this.data,
  });

  factory ResponseBooked.fromJson(Map<String, dynamic> json) {
    return ResponseBooked(
      message: json['message'],
      data: ListBooked.fromJson(json['data']),
    );
  }
}

class ListBooked {
  final int count;
  final List<BookingInfo> rows;

  const ListBooked({
    required this.count,
    required this.rows,
  });

  factory ListBooked.fromJson(Map<String, dynamic> json) {
    return ListBooked(
      count: json['count'],
      rows: List<BookingInfo>.from(
        json['rows'].map(
          (booked) => BookingInfo.fromJson(booked),
        ),
      ),
    );
  }
}
