import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test_route/widgets/button.dart';
import 'package:test_route/widgets/footer.dart';
import 'package:test_route/widgets/header.dart';
import 'package:test_route/widgets/mainBody.dart';

class LessonCard extends StatelessWidget {
  const LessonCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
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
          const LessonCard(),
        ],
      ),
    );
  }
}

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 35),
      child: const Column(
        children: [
          Header(
            'Booking List',
            descriptions: [
              'This is your list of reservations',
              'You can keep track that who do book you, when do the meeting start and join meeting by a click',
            ],
            image: 'assets/images/calendar-check.svg',
          ),
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
        ],
      ),
    );
  }
}

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainBody(Body());
  }
}
