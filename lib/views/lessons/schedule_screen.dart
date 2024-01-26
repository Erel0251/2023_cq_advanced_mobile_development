import 'package:flutter/material.dart';
import 'package:let_tutor_app/controllers/schedule_controller.dart';
import 'package:let_tutor_app/models/schedule/booking_info.dart';
import 'package:let_tutor_app/models/schedule/response_booked.dart';
import 'package:let_tutor_app/models/tutor/account_info.dart';
import 'package:let_tutor_app/widgets/card.dart';
import 'package:let_tutor_app/widgets/header.dart';
import 'package:let_tutor_app/widgets/body.dart';
import 'package:let_tutor_app/widgets/pagination.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

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
    futureBookedClass = getFutureBookedClass();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _header(),
          ..._latestBook(),
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
      'Schedule',
      descriptions: [
        'Here is a list of the sessions you have booked',
        'You can track when the meeting starts, join the meeting with one click or can cancel the meeting before 2 hours',
      ],
      image: 'assets/images/calendar-check.svg',
    );
  }

  List<Widget> _latestBook() {
    return [
      const Text(
        'Latest Book',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, height: 3),
      ),
      Table(
        border: TableBorder.all(color: Colors.black26),
        columnWidths: const <int, TableColumnWidth>{
          0: IntrinsicColumnWidth(),
          1: FlexColumnWidth(),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          TableRow(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                color: Colors.white12,
                child: const Text(
                  'Name',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Table(
                border: TableBorder.symmetric(
                    inside: const BorderSide(color: Colors.black26)),
                children: [
                  TableRow(children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      alignment: Alignment.center,
                      color: Colors.white,
                      child: const Text(
                        'sample.pdf',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      alignment: Alignment.center,
                      color: Colors.white12,
                      child: const Text(
                        'Page',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      alignment: Alignment.center,
                      color: Colors.white,
                      child: const Text(
                        '0',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ]),
                ],
              )
            ],
          ),
          TableRow(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                color: Colors.white12,
                child: const Text(
                  'Description',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Container(
                color: Colors.white,
                child: const Text(
                  '',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ],
      ),
    ];
  }

  List<Widget> _lessonCards({List<BookingInfo> data = const []}) {
    return data.map((e) {
      TutorInfo tutor = e.getTutor();
      String courseTime =
          '${e.scheduleDetailInfo!.startPeriod} - ${e.scheduleDetailInfo!.endPeriod}';

      // uncancelable when time is less than 2 hours
      // which can be calculated by comparing current time and start lesson time
      bool cancelable = e.isCancelable();

      return LessonCard(
        id: e.scheduleDetailInfo!.id,
        date: e.scheduleDetailInfo!.getLessonDate(),
        time: '1 lesson',
        courseTime: courseTime,
        cancelable: cancelable,
        nameTutor: tutor.name!,
        avatar: tutor.avatar!,
        code: tutor.country,
        country: tutor.language,
        studentRequest: e.studentRequest,
        callable: true,
      );
    }).toList();
  }
}

class Reservation extends StatelessWidget {
  const Reservation(
      {required this.time,
      required this.date,
      required this.status,
      super.key});

  final String time;
  final String date;
  final String status;

  Color checkStatus() {
    if (status == 'OPEN') {
      return Colors.blue;
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(15),
      color: const Color.fromRGBO(241, 241, 241, 1),
      child: Column(
        children: [
          Row(
            //alignment: WrapAlignment.spaceBetween,
            children: [
              Expanded(
                child: Wrap(
                  spacing: 25,
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      time,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      date,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Status',
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    status,
                    style: TextStyle(fontSize: 18, color: checkStatus()),
                  ),
                ],
              )
            ],
          ),
          //const LessonCard(),
        ],
      ),
    );
  }
}




/*

          Reservation(
            time: '18:00 - 18:25',
            date: 'Tue, 31 Oct 23',
            status: 'OPEN',
          ),
          Reservation(
            time: '18:30 - 18:55',
            date: 'Tue, 31 Oct 23',
            status: 'CLOSED',
          ),
          Reservation(
            time: '19:00 - 19:25',
            date: 'Tue, 31 Oct 23',
            status: 'OPEN',
          ),
          Reservation(
            time: '19:30 - 19:55',
            date: 'Tue, 31 Oct 23',
            status: 'CLOSED',
          ),
          Reservation(
            time: '20:00 - 20:25',
            date: 'Tue, 31 Oct 23',
            status: 'OPEN',
          ),
          Reservation(
            time: '20:30 - 20:55',
            date: 'Tue, 31 Oct 23',
            status: 'OPEN',
          ),
          Reservation(
            time: '21:00 - 21:25',
            date: 'Tue, 31 Oct 23',
            status: 'CLOSED',
          ),
          Reservation(
            time: '21:30 - 21:55',
            date: 'Tue, 31 Oct 23',
            status: 'OPEN',
          ),
          Reservation(
            time: '22:00 - 22:25',
            date: 'Tue, 31 Oct 23',
            status: 'OPEN',
          ),
          Reservation(
            time: '22:30 - 22:55',
            date: 'Tue, 31 Oct 23',
            status: 'OPEN',
          ),
          Reservation(
            time: '23:00 - 23:25',
            date: 'Tue, 31 Oct 23',
            status: 'OPEN',
          ),
          Reservation(
            time: '23:30 - 23:55',
            date: 'Tue, 31 Oct 23',
            status: 'OPEN',
          ),
*/
