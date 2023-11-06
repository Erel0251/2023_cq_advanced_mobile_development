import 'package:flutter/material.dart';
import 'package:test_route/widgets/card.dart';
import 'package:test_route/widgets/header.dart';
import 'package:test_route/widgets/body.dart';

class NavigationBar extends StatelessWidget {
  const NavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black12)),
      ),
      child: TabBar(
        isScrollable: true,
        tabs: [
          Tab(
            child: Container(
              margin: const EdgeInsets.only(right: 15),
              padding: const EdgeInsets.symmetric(vertical: 8),
              //decoration: const BoxDecoration(
              //  border: Border(bottom: BorderSide(color: Colors.blue)),
              //),
              child:
                  const Text('Course', style: TextStyle(color: Colors.black)),
            ),
          ),
          Tab(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              padding: const EdgeInsets.symmetric(vertical: 8),
              child:
                  const Text('E-Book', style: TextStyle(color: Colors.black)),
            ),
          ),
          Tab(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: const Text('Interactive E-book',
                  style: TextStyle(color: Colors.black)),
            ),
          ),
        ],
      ),
    );
  }
}

class FilterCourses extends StatefulWidget {
  const FilterCourses(
    this.list, {
    required this.hint,
    super.key,
  });
  final List<String> list;
  final String hint;
  @override
  State<FilterCourses> createState() => _FilterCoursesState();
}

class _FilterCoursesState extends State<FilterCourses> {
  String dropdownValue = '';
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: DropdownMenu<String>(
        width: 250,
        hintText: widget.hint,
        onSelected: (String? value) {
          setState(() {
            dropdownValue = value!;
          });
        },
        dropdownMenuEntries:
            widget.list.map<DropdownMenuEntry<String>>((String value) {
          return DropdownMenuEntry<String>(value: value, label: value);
        }).toList(),
      ),
    );
  }
}

class CourseTab extends StatelessWidget {
  const CourseTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          'English For Traveling',
          style:
              TextStyle(fontSize: 26, fontWeight: FontWeight.bold, height: 2),
        ),
        Wrap(
          alignment: WrapAlignment.spaceEvenly,
          children: [
            CourseCard(
              'Life in the Internet Age',
              image: 'assets/images/banner01.png',
              description:
                  "Let's discuss how technology is changing the way we live",
              level: 'Intermediate',
              totalLesson: 9,
            ),
            CourseCard(
              'Caring for Our Planet',
              image: 'assets/images/banner02.png',
              description:
                  "Let's discuss our relationship as humans with our planet, Earth",
              level: 'Intermediate',
              totalLesson: 6,
            ),
            CourseCard(
              'Healthy Mind, Healthy Body',
              image: 'assets/images/banner03.png',
              description:
                  "Let's discuss the many aspects of living a long, happy life",
              level: 'Intermediate',
              totalLesson: 6,
            ),
          ],
        ),
        Text(
          'English For Traveling',
          style:
              TextStyle(fontSize: 26, fontWeight: FontWeight.bold, height: 2),
        ),
        Wrap(
          alignment: WrapAlignment.spaceEvenly,
          children: [
            CourseCard(
              'Basic Conversation Topics',
              image: 'assets/images/banner07.png',
              description: "Gain confidence speaking about familiar topics",
              level: 'Beginner',
              totalLesson: 10,
            ),
            CourseCard(
              'Intermediate Conversation Topics',
              image: 'assets/images/banner08.png',
              description: "Express your ideas and opinions",
              level: 'Intermediate',
              totalLesson: 10,
            ),
            CourseCard(
              'Advanced Conversation Topics',
              image: 'assets/images/banner09.png',
              description: "Explore complex topics relevant to modern life",
              level: 'Advanced',
              totalLesson: 10,
            ),
          ],
        ),
        Text(
          'Business English',
          style:
              TextStyle(fontSize: 26, fontWeight: FontWeight.bold, height: 2),
        ),
        Wrap(
          alignment: WrapAlignment.spaceEvenly,
          children: [
            CourseCard(
              'Business English',
              image: 'assets/images/banner10.png',
              description: "The English you need for your work and career",
              level: 'Intermediate',
              totalLesson: 10,
            ),
            CourseCard(
              'Advanced Business English',
              image: 'assets/images/banner11.png',
              description: "Advanced English for your work and career",
              level: 'Advanced',
              totalLesson: 14,
            ),
            CourseCard(
              'Workshop: Practicing Presentations',
              image: 'assets/images/banner12.png',
              description: "Practice an upcoming presentation or speech ",
              level: 'Any Level',
              totalLesson: 4,
            ),
          ],
        ),
        Text(
          'English For Kid',
          style:
              TextStyle(fontSize: 26, fontWeight: FontWeight.bold, height: 2),
        ),
        Wrap(
          alignment: WrapAlignment.spaceEvenly,
          children: [
            CourseCard(
              'IELTS Speaking Part 1',
              image: 'assets/images/banner13.png',
              description:
                  "Practice answering Part 1 questions from past years' IELTS exams",
              level: 'Any Level',
              totalLesson: 8,
            ),
            CourseCard(
              'IELTS Speaking Part 2',
              image: 'assets/images/banner14.png',
              description:
                  "Practice answering Part 2 questions from past years' IELTS exams",
              level: 'Any Level',
              totalLesson: 8,
            ),
            CourseCard(
              'IELTS Speaking Part 3',
              image: 'assets/images/banner15.png',
              description:
                  "Practice answering Part 3 questions from past years' IELTS exams",
              level: 'Any Level',
              totalLesson: 8,
            ),
          ],
        ),
      ],
    );
  }
}

class EbookTab extends StatelessWidget {
  const EbookTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class InteractiveEbookTab extends StatelessWidget {
  const InteractiveEbookTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 35, vertical: 35),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DiscoverCoursesHeader(
            'Discover Courses',
            description:
                "LiveTutor has built the most quality, methodical and scientific courses in the fields of life for those who are in need of improving their knowledge of the fields.",
            image: 'assets/images/course.svg',
          ),
          Wrap(
            children: [
              FilterCourses(
                ['Any Level', 'Beginner', 'Intermediate', 'Advanced'],
                hint: 'Select level',
              ),
              FilterCourses(
                [
                  'For Studying Abroad',
                  'English For Traveling',
                  'Conversational ENglish',
                  'English For Beginners',
                  'Business English'
                ],
                hint: 'Select category',
              ),
              FilterCourses(
                [
                  'Level decreasing',
                  'Level ascending',
                ],
                hint: 'Sort by level',
              ),
            ],
          ),
          NavigationBar(),
          SizedBox(
            height: double.maxFinite,
            child: TabBarView(
              children: [
                CourseTab(),
                EbookTab(),
                InteractiveEbookTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CoursesScreen extends StatelessWidget {
  const CoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(length: 3, child: MainBody(Body()));
  }
}
