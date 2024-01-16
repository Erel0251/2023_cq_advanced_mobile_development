import 'package:flutter/material.dart';
import 'package:test_route/controllers/course_action.dart';
import 'package:test_route/models/course/course_detail.dart';
import 'package:test_route/models/course/response_courses.dart';
import 'package:test_route/widgets/card.dart';
import 'package:test_route/widgets/header.dart';
import 'package:test_route/widgets/body.dart';

class CoursesScreen extends StatelessWidget {
  const CoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 3, child: MainBody(Body()));
  }
}

class Body extends StatefulWidget {
  Body({super.key});

  final List<String> coursesLevel = [
    'Any Level',
    'Beginner',
    'Intermediate',
    'Advanced',
  ];

  final List<String> coursesCategory = [
    'For Studying Abroad',
    'English For Traveling',
    'Conversational ENglish',
    'English For Beginners',
    'Business English'
  ];

  final List<String> coursesSort = [
    'Level decreasing',
    'Level ascending',
  ];

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late Future<ListCourses> futureCourses;

  @override
  void initState() {
    super.initState();
    futureCourses = fetchCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 35, vertical: 35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const DiscoverCoursesHeader(
            'Discover Courses',
            description:
                "LiveTutor has built the most quality, methodical and scientific courses in the fields of life for those who are in need of improving their knowledge of the fields.",
            image: 'assets/images/course.svg',
          ),
          Wrap(
            children: [
              FilterCourses(
                widget.coursesLevel,
                hint: 'Select level',
              ),
              FilterCourses(
                widget.coursesCategory,
                hint: 'Select category',
              ),
              FilterCourses(
                widget.coursesSort,
                hint: 'Sort by level',
              ),
            ],
          ),
          const NavigationBar(),
          SizedBox(
            height: double.maxFinite,
            child: TabBarView(
              children: [
                FutureBuilder(
                  future: futureCourses,
                  builder: (((context, snapshot) {
                    if (snapshot.hasData) {
                      return CourseTab(mapCoursesByCategory(
                          (snapshot.data as ListCourses).rows));
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  })),
                ),
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
  const CourseTab(this.listCourses, {super.key});

  final Map<String, List<CourseDetailData>> listCourses;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: listCourses.keys.map((category) {
        return Column(
          children: courseByCategory(category),
        );
      }).toList(),
    );
  }

  List<Widget> courseByCategory(String category) {
    return [
      Text(
        category,
        style: const TextStyle(
            fontSize: 26, fontWeight: FontWeight.bold, height: 2),
      ),
      Wrap(
          alignment: WrapAlignment.spaceEvenly,
          children: listCourses[category]!.map((course) {
            return CourseCard(
              course.id,
              title: course.name,
              image: course.imageUrl!,
              description: course.description,
              level: course.level,
              totalLesson: course.topics!.length,
            );
          }).toList())
    ];
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
