import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test_route/views/tutor_screen.dart';
import 'package:test_route/widgets/avatar.dart';
import 'package:test_route/widgets/button.dart';
import 'package:test_route/widgets/footer.dart';
import 'package:test_route/widgets/header.dart';
import 'package:test_route/widgets/pagination.dart';

class DetailCard extends StatelessWidget {
  const DetailCard({
    required this.child,
    this.margin = const EdgeInsets.symmetric(vertical: 1),
    this.height,
    super.key,
  });

  final EdgeInsetsGeometry margin;
  final double? height;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: margin,
      padding: const EdgeInsets.all(8),
      color: Colors.white,
      child: child,
    );
  }
}

class Rating extends StatelessWidget {
  const Rating({this.rate = 0, super.key});

  final int rate;

  @override
  Widget build(BuildContext context) {
    return DetailCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (rate == 0)
            const Text(
              'Add a Rating',
              style: TextStyle(color: Colors.blue),
            )
          else ...[
            Row(
              children: [const Text('Rating: '), Stars(rate)],
            ),
            const Text(
              'Edit',
              style: TextStyle(color: Colors.blue),
            ),
          ],
          const Text(
            'Report',
            style: TextStyle(color: Colors.blue),
          ),
        ],
      ),
    );
  }
}

class ReviewCard extends StatelessWidget {
  const ReviewCard(
      {required this.time,
      required this.date,
      required this.courseTime,
      required this.avatar,
      this.code,
      this.country,
      this.rate = 0,
      super.key});

  final String time;
  final String date;
  final String courseTime;
  final String avatar;
  final String? code;
  final String? country;
  final int rate;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      padding: const EdgeInsets.all(16),
      color: const Color.fromRGBO(238, 238, 238, 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            date,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            time,
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 10),
          DetailCard(
            height: 100,
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Avatar(
              'Keegan',
              avatar: 'assets/images/avatar01.jpg',
              edge: 68,
              alignment: CrossAxisAlignment.start,
              detailAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (code != null)
                  Row(
                    children: [
                      Flag.fromString(
                        code!,
                        height: 22,
                        width: 22,
                      ),
                      Text(country!),
                    ],
                  ),
                const Row(
                  children: [
                    Icon(
                      Icons.chat_outlined,
                      size: 14,
                      color: Colors.blue,
                    ),
                    Text(
                      ' Direct Message',
                      style: TextStyle(fontSize: 14, color: Colors.blue),
                    )
                  ],
                )
              ],
            ),
          ),
          DetailCard(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                Text(
                  'Lesson Time: $courseTime',
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
          const DetailCard(
            child: Row(
              children: [
                Text(
                  'No request for lesson',
                ),
              ],
            ),
          ),
          const DetailCard(
            child: Row(
              children: [
                Text(
                  "Tutor haven't reviewed yet",
                ),
              ],
            ),
          ),
          DetailCard(
            child: Rating(
              rate: rate,
            ),
          ),
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
            'History',
            descriptions: [
              'The following is a list of lessons you have attended',
              'You can review the details of the lessons you have attended'
            ],
            image: 'assets/images/history-meeting.svg',
          ),
          ReviewCard(
            time: '2 days ago',
            date: 'Sun, 29 Oct 23',
            courseTime: '14:30 - 15:25',
            avatar: 'assets/images/avatar01.jpg',
            code: 'TN',
            country: ' Tunisia',
            rate: 5,
          ),
          ReviewCard(
            time: '2 days ago',
            date: 'Sun, 29 Oct 23',
            courseTime: '01:30 - 01:55',
            avatar: 'assets/images/avatar01.jpg',
            code: 'TN',
            country: ' Tunisia',
            rate: 4,
          ),
          ReviewCard(
            time: '3 days ago',
            date: 'Sat, 28 Oct 23',
            courseTime: '15:30 - 15:55',
            avatar: 'assets/images/avatar01.jpg',
            code: 'TN',
            country: ' Tunisia',
          ),
          ReviewCard(
            time: '5 days ago',
            date: 'Thu, 26 Oct 23',
            courseTime: '00:00 - 00:25',
            avatar: 'assets/images/avatar01.jpg',
            code: 'TN',
            country: ' Tunisia',
            rate: 1,
          ),
          Pagination(5),
        ],
      ),
    );
  }
}

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.white,
        title: SvgPicture.asset(
          'assets/images/lettutor_logo.svg',
          width: 150.0,
          fit: BoxFit.fitWidth,
        ),
        actions: const <Widget>[
          LanguageButton(),
          MenuButton(),
        ],
      ),
      body: ListView(
        children: const [
          Body(),
          Footer(),
        ],
      ),
      floatingActionButton: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: <Widget>[
          FloatingActionButton(
            backgroundColor: const Color.fromRGBO(128, 128, 128, 1),
            onPressed: () {},
            child: const Icon(Icons.chat_outlined),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 80),
            child: FloatingActionButton(
              backgroundColor: const Color.fromRGBO(128, 128, 128, 1),
              onPressed: () {},
              child: const Icon(Icons.card_giftcard),
            ),
          ),
        ],
      ),
    );
  }
}
