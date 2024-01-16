import 'package:flutter/material.dart';

import 'package:test_route/models/course/course_detail.dart';
import 'package:test_route/models/course/topic.dart';

import 'package:test_route/widgets/body.dart';
import 'package:test_route/widgets/network_image.dart';

class CourseDetailScreen extends StatelessWidget {
  const CourseDetailScreen(
    this.course, {
    this.order = 0,
    super.key,
  });

  final CourseDetailData course;
  final int order;

  @override
  Widget build(BuildContext context) {
    return MainBody(Body(course, order: order));
  }
}

class Body extends StatefulWidget {
  const Body(this.course, {this.order = 0, super.key});
  final CourseDetailData course;
  final int order;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int picked = 0;
  String? pdfUrl = '';

  @override
  void initState() {
    super.initState();
    picked = widget.order;
    pdfUrl = widget.course.topics![picked].nameFile;
  }

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
          ..._banner(widget.course),
          ..._listTopics(widget.course.topics),
          //SfPdfViewer.network(pdfUrl!),
        ],
      ),
    );
  }

  List<Widget> _banner(CourseDetailData course) {
    return [
      ImageNetwork(course.imageUrl),
      Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              course.name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              course.description,
              softWrap: true,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    ];
  }

  List<Widget> _listTopics(List<Topic>? topics) {
    return [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
        child: const Text(
          'List Topics',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      topics != null
          ? Column(
              children: topics.map((e) => _topicName(e)).toList(),
            )
          : const SizedBox(),
    ];
  }

  Widget _topicName(Topic topic) {
    return Container(
      width: double.maxFinite,
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: topic.orderCourse == picked
            ? const Color.fromRGBO(0, 0, 0, 0.08)
            : Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: GestureDetector(
        onTap: () => _pickTopic(topic),
        child: Row(
          children: [
            if (topic.orderCourse != null)
              Text(
                '${topic.orderCourse}.  ',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            Text(
              topic.name!,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  void _pickTopic(Topic topic) {
    setState(() {
      picked = topic.orderCourse!;
      pdfUrl = topic.nameFile;
    });
  }
}
