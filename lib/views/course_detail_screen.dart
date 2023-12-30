import 'package:flutter/material.dart';
import 'package:test_route/widgets/body.dart';

class CourseDetailScreen extends StatelessWidget {
  const CourseDetailScreen({super.key});

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
      width: double.maxFinite,
      margin: const EdgeInsets.symmetric(vertical: 35, horizontal: 10),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ..._banner(),
          ..._listTopics(),
        ],
      ),
    );
  }

  List<Widget> _banner() {
    return [
      Image.asset('assets/images/banner07.png'),
      Container(
        padding: const EdgeInsets.all(24),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Basic Conversation Topics',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              "   Gain confidence speaking about familiar topics",
              softWrap: true,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    ];
  }

  List<Widget> _listTopics() {
    return [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
        child: const Text(
          'List Topics',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      DetailTopic('Foods You Love', index: 1, isPicked: true),
      DetailTopic('Your Job', index: 2),
      DetailTopic('Playing and Watching Sports', index: 3),
      DetailTopic('The Best Pet', index: 4),
      DetailTopic('Having Fun in Your Free Time', index: 5),
      DetailTopic('Your Daily Rountine', index: 6),
      DetailTopic('Childhood Memories', index: 7),
      DetailTopic('Your Family Members', index: 8),
      DetailTopic('Your Hometown', index: 9),
      DetailTopic('Shopping Habits', index: 10),
    ];
  }
}

class DetailTopic extends StatelessWidget {
  const DetailTopic(this.title, {this.index, this.isPicked = false, super.key});

  final String title;
  final int? index;
  final bool isPicked;

  Color checkPicked() {
    return (isPicked) ? const Color.fromRGBO(0, 0, 0, 0.08) : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          color: checkPicked(), borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          if (index != null)
            Text(
              '$index.  ',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
