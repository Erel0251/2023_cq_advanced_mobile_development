import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test_route/widgets/button.dart';
import 'package:test_route/widgets/footer.dart';
import 'package:test_route/widgets/mainBody.dart';

class DetailTopic extends StatelessWidget {
  const DetailTopic(this.title, {this.index, this.isPicked = false, super.key});

  final String title;
  final int? index;
  final bool isPicked;

  Color checkPicked() {
    return (isPicked) ? Color.fromRGBO(0, 0, 0, 0.08) : Colors.white;
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
          Image.asset('assets/images/banner07.png'),
          Container(
            height: 120,
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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
            child: const Text(
              'List Topics',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          const DetailTopic('Foods You Love', index: 1, isPicked: true),
          const DetailTopic('Your Job', index: 2),
          const DetailTopic('Playing and Watching Sports', index: 3),
          const DetailTopic('The Best Pet', index: 4),
          const DetailTopic('Having Fun in Your Free Time', index: 5),
          const DetailTopic('Your Daily Rountine', index: 6),
          const DetailTopic('Childhood Memories', index: 7),
          const DetailTopic('Your Family Members', index: 8),
          const DetailTopic('Your Hometown', index: 9),
          const DetailTopic('Shopping Habits', index: 10),
        ],
      ),
    );
  }
}

class CourseDetailScreen extends StatelessWidget {
  const CourseDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainBody(Body());
  }
}
