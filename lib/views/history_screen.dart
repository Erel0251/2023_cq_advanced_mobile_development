import 'package:flutter/material.dart';
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

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 35),
      child: Column(
        children: [
          _header(),
          ..._lessonCards(),
          const Pagination(5),
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

  List<Widget> _lessonCards() {
    return const [
      LessonCard(
        time: '2 days ago',
        date: 'Sun, 29 Oct 23',
        courseTime: '14:30 - 15:25',
        avatar: 'assets/images/avatar01.jpg',
        code: 'TN',
        country: ' Tunisia',
        rate: 5,
      ),
      LessonCard(
        time: '2 days ago',
        date: 'Sun, 29 Oct 23',
        courseTime: '01:30 - 01:55',
        avatar: 'assets/images/avatar01.jpg',
        code: 'TN',
        country: ' Tunisia',
        rate: 4,
      ),
      LessonCard(
        time: '3 days ago',
        date: 'Sat, 28 Oct 23',
        courseTime: '15:30 - 15:55',
        avatar: 'assets/images/avatar01.jpg',
        code: 'TN',
        country: ' Tunisia',
      ),
      LessonCard(
        time: '5 days ago',
        date: 'Thu, 26 Oct 23',
        courseTime: '00:00 - 00:25',
        avatar: 'assets/images/avatar01.jpg',
        code: 'TN',
        country: ' Tunisia',
        rate: 1,
      ),
    ];
  }
}
