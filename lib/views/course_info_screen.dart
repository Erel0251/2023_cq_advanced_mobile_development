import 'package:flutter/material.dart';
import 'package:test_route/views/course_detail_screen.dart';
import 'package:test_route/widgets/card.dart';
import 'package:test_route/widgets/body.dart';

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

class Topic extends StatelessWidget {
  const Topic(this.title, {this.index, super.key});

  final String title;
  final int? index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CourseDetailScreen()),
        );
      },
      child: Container(
        width: double.maxFinite,
        height: 130,
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.circular(8)),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (index != null)
                Text(
                  '$index.',
                  style: const TextStyle(fontSize: 16),
                ),
              Text(
                title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ]),
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
      child: Column(children: [
        CourseCard(
          'Basic Conversation Topics',
          image: 'assets/images/banner07.png',
          description: "Gain confidence speaking about familiar topics",
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
        ),
        const Part('Overview', children: [
          Content(
            'Why take this course',
            icon: Icon(
              Icons.question_mark_sharp,
              size: 20,
              color: Colors.red,
            ),
            content:
                "It can be intimidating to speak with a foreigner, no matter how much grammar and vocabulary you've mastered. If you have basic knowledge of English but have not spent much time speaking, this course will help you ease into your first English conversations.",
          ),
          Content(
            'What will you be able to do',
            icon: Icon(
              Icons.question_mark_sharp,
              size: 16,
              color: Colors.red,
            ),
            content:
                "This course covers vocabulary at the CEFR A2 level. You will build confidence while learning to speak about a variety of common, everyday topics. In addition, you will build implicit grammar knowledge as your tutor models correct answers and corrects your mistakes.",
          ),
        ]),
        const Part(
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
        ),
        const Part(
          'Course Length',
          children: [
            Content(
              '10 topics ',
              icon: Icon(
                Icons.book_outlined,
                size: 20,
                color: Colors.blue,
              ),
            )
          ],
        ),
        const Part(
          'List Topics',
          children: [
            Topic('Foods You Love', index: 1),
            Topic('Your Job', index: 2),
            Topic('Playing and Watching Sports', index: 3),
            Topic('The Best Pet', index: 4),
            Topic('Having Fun in Your Free Time', index: 5),
            Topic('Your Daily Rountine', index: 6),
            Topic('Childhood Memories', index: 7),
            Topic('Your Family Members', index: 8),
            Topic('Your Hometown', index: 9),
            Topic('Shopping Habits', index: 10),
          ],
        ),
        const Part(
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
        )
      ]),
    );
  }
}

class CourseInfoScreen extends StatelessWidget {
  const CourseInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainBody(Body());
  }
}
