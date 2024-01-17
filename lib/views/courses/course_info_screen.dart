import 'package:flutter/material.dart';
import 'package:let_tutor_app/controllers/course_controller.dart';
import 'package:let_tutor_app/models/course/course_detail.dart';
import 'package:let_tutor_app/models/course/topic.dart';
import 'package:let_tutor_app/views/courses/course_detail_screen.dart';
import 'package:let_tutor_app/widgets/card.dart';
import 'package:let_tutor_app/widgets/body.dart';

class CourseInfoScreen extends StatelessWidget {
  const CourseInfoScreen(this.idCourse, {super.key});
  final String idCourse;

  @override
  Widget build(BuildContext context) {
    return MainBody(Body(idCourse));
  }
}

class Body extends StatefulWidget {
  const Body(this.idCourse, {super.key});
  final String idCourse;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late Future<CourseDetailData> futureCourseDetail;

  @override
  void initState() {
    super.initState();
    futureCourseDetail = fetchCourseById(widget.idCourse);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 35),
      child: FutureBuilder(
        future: futureCourseDetail,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return courseDetailData(snapshot.data as CourseDetailData);
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }

  Widget courseDetailData(CourseDetailData data) {
    return Column(
      children: [
        _courseCard(data),
        _overview(data.reason, data.purpose),
        _experienceLevel(data),
        _numberOfTopics(data.topics!.length),
        _listTopics(data),
        _suggestTutors(),
      ],
    );
  }

  Widget _courseCard(CourseDetailData data) {
    return CourseCard(
      data.id,
      title: data.name,
      image: data.imageUrl!,
      description: data.description,
      child: GestureDetector(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: const Color.fromRGBO(0, 113, 240, 1),
          ),
          child: const Text(
            'Discover',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _overview(String? reason, String? purpose) {
    return Part(
      'Overview',
      children: [
        Content(
          'Why take this course',
          icon: const Icon(
            Icons.question_mark_sharp,
            size: 20,
            color: Colors.red,
          ),
          content: reason,
        ),
        Content(
          'What will you be able to do',
          icon: const Icon(
            Icons.question_mark_sharp,
            size: 16,
            color: Colors.red,
          ),
          content: purpose,
        ),
      ],
    );
  }

  Widget _experienceLevel(CourseDetailData data) {
    return const Part(
      'Experience Level',
      children: [
        Content(
          'Beginner',
          icon: Icon(
            Icons.group_add_outlined,
            size: 20,
            color: Colors.blue,
          ),
        )
      ],
    );
  }

  Widget _numberOfTopics(int length) {
    return Part(
      'Course Length',
      children: [
        Content(
          '$length topics ',
          icon: const Icon(
            Icons.book_outlined,
            size: 20,
            color: Colors.blue,
          ),
        )
      ],
    );
  }

  Widget _listTopics(CourseDetailData course) {
    return Part('List Topics',
        children: course.topics!.asMap().entries.map((e) {
          return TopicInfo(course, order: e.key);
        }).toList());
  }

  Widget _suggestTutors() {
    return const Part(
      'Suggested Tutors',
      children: [
        Row(
          children: [
            Text(
              'Keegan',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              ' More info',
              style: TextStyle(color: Colors.blue),
            ),
          ],
        )
      ],
    );
  }
}

class Part extends StatelessWidget {
  const Part(this.title, {required this.children, super.key});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [
          const Expanded(child: Divider(color: Colors.black45)),
          Text(
            " $title ",
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const Expanded(flex: 5, child: Divider(color: Colors.black45)),
        ]),
        const SizedBox(height: 10),
        ...children,
        const SizedBox(height: 10),
      ],
    );
  }
}

class Content extends StatelessWidget {
  const Content(this.title, {required this.icon, this.content, super.key});

  final Widget icon;
  final String title;
  final String? content;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon,
            Text(
              '  $title',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        if (content != null)
          Container(
            padding: const EdgeInsets.fromLTRB(25, 5, 10, 20),
            child: Text(
              content!,
              softWrap: true,
            ),
          )
      ],
    );
  }
}

class TopicInfo extends StatelessWidget {
  const TopicInfo(this.course, {required this.order, super.key});

  final CourseDetailData course;
  final int order;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.maxFinite,
        height: 130,
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.circular(8)),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      CourseDetailScreen(course, order: order)),
            );
          },
          child: _topicCard(course.topics![order]),
        ));
  }

  Widget _topicCard(topic) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (topic.orderCourse != null)
            Text(
              '${topic.orderCourse!}.',
              style: const TextStyle(fontSize: 16),
            ),
          Text(
            topic.name!,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ]);
  }
}
