import 'package:flutter/material.dart';
import 'package:let_tutor_app/controllers/schedule_controller.dart';
import 'package:let_tutor_app/models/schedule/booking_info.dart';
import 'package:let_tutor_app/models/schedule/response_booked.dart';
import 'package:let_tutor_app/models/tutor/account_info.dart';
import 'package:let_tutor_app/widgets/card.dart';
import 'package:let_tutor_app/widgets/header.dart';
import 'package:let_tutor_app/widgets/body.dart';
import 'package:let_tutor_app/widgets/pagination.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainBody(Body());
  }
}

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late Future<ListBooked> futureBookedClass;

  @override
  void initState() {
    super.initState();
    futureBookedClass = getHistoryBookedClass();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 35),
      child: Column(
        children: [
          _header(),
          FutureBuilder(
              future: futureBookedClass,
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      ..._lessonCards(data: snapshot.data!.rows),
                      Pagination(snapshot.data!.count, itemPerPage: 20),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return const CircularProgressIndicator();
              }))
        ],
      ),
    );
  }

  Widget _header() {
    return const Header(
      'History',
      descriptions: [
        'The following is a list of lessons you have attended',
        'You can review the details of the lessons you have attended'
      ],
      image: 'assets/images/history-meeting.svg',
    );
  }

  List<Widget> _lessonCards({List<BookingInfo> data = const []}) {
    return data.map((e) {
      TutorInfo tutor = e.getTutor();
      String courseTime =
          '${e.scheduleDetailInfo!.startPeriod} - ${e.scheduleDetailInfo!.endPeriod}';

      return LessonCard(
        date: e.scheduleDetailInfo!.getLessonDate(),
        time: e.scheduleDetailInfo!.getLessonRangeDate(),
        courseTime: courseTime,
        nameTutor: tutor.name!,
        avatar: tutor.avatar!,
        code: tutor.country,
        country: tutor.language,
        rates: e.feedbacks!.map((e) => e.rating!).toList(),
      );
    }).toList();
  }
}
