import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:let_tutor_app/controllers/course_controller.dart';

import 'package:let_tutor_app/models/course/course_detail.dart';
import 'package:let_tutor_app/models/course/response_courses.dart';

import 'package:let_tutor_app/providers/course_provider.dart';

import 'package:let_tutor_app/widgets/card.dart';
import 'package:let_tutor_app/widgets/header.dart';
import 'package:let_tutor_app/widgets/body.dart';

class CoursesScreen extends StatelessWidget {
  const CoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: MainBody(
        ChangeNotifierProvider(
          create: (context) => CoursesFilterProvider(),
          child: const Body(),
        ),
      ),
    );
  }
}

class Body extends StatelessWidget {
  const Body({super.key});

  final List<String> coursesLevel = const [
    'Any Level',
    'Beginner',
    'Upper-Beginner',
    'Pre-Intermediate',
    'Intermediate',
    'Upper-Intermediate',
    'Pre-Advanced',
    'Advanced',
    'Very Advanced',
  ];

  final List<String> coursesCategory = const [
    'For Studying Abroad',
    'English For Traveling',
    'Conversational ENglish',
    'English For Beginners',
    'Business English',
    'English for kid',
    'STARTERS',
    'PET',
    'KET',
    'MOVERS',
    'FLYERS',
    'IELTS',
    'TOEIC',
    'TOEFL',
  ];

  final List<String> coursesSort = const [
    'Level decreasing',
    'Level ascending',
  ];

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
                coursesLevel,
                hint: 'Select level',
              ),
              FilterCourses(
                coursesCategory,
                hint: 'Select category',
              ),
              FilterCourses(
                coursesSort,
                hint: 'Sort by level',
              ),
            ],
          ),
          _navigationBar(context),
          SizedBox(
            height: double.maxFinite,
            child: TabBarView(
              children: [
                _coursesInfo(context),
                _coursesInfo(context),
                _coursesInfo(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _navigationBar(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black12)),
      ),
      child: TabBar(
        isScrollable: true,
        tabs: [
          Tab(
            child: GestureDetector(
              onTap: () => fetchCoursesByType(context, 'course'),
              child: _buttonTabBar('Courses'),
            ),
          ),
          Tab(
            child: GestureDetector(
              onTap: () => fetchCoursesByType(context, 'e-book'),
              child: _buttonTabBar('E-Book'),
            ),
          ),
          Tab(
            child: GestureDetector(
              onTap: () => fetchCoursesByType(context, 'interactive-e-book'),
              child: _buttonTabBar('Interactive E-book'),
            ),
          ),
        ],
      ),
    );
  }

  void fetchCoursesByType(BuildContext context, String tabType) {
    if (context.read<CoursesFilterProvider>().type != tabType) {
      context.read<CoursesFilterProvider>().setType(tabType);
    }
  }

  Widget _buttonTabBar(String tabName) {
    return Container(
      margin: const EdgeInsets.only(right: 15),
      padding: const EdgeInsets.symmetric(vertical: 8),
      //decoration: const BoxDecoration(
      //  border: Border(bottom: BorderSide(color: Colors.blue)),
      //),
      child: Text(tabName, style: const TextStyle(color: Colors.black)),
    );
  }

  Widget _coursesInfo(BuildContext context) {
    return FutureBuilder(
      future: context.watch<CoursesFilterProvider>().filterCourses(),
      builder: (((context, snapshot) {
        if (snapshot.hasData) {
          return ((snapshot.data as ListCourses).count > 0)
              ? CourseTab(
                  mapCoursesByCategory((snapshot.data as ListCourses).rows))
              : const Center(
                  child: Text('No data'),
                );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      })),
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
          context
              .read<CoursesFilterProvider>()
              .checkTypeFilter(widget.hint, widget.list.indexOf(value!));
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
              level: const Body().coursesLevel[int.parse(course.level!)],
              filelUrl: course.fileUrl,
              totalLesson: course.topics != null ? course.topics!.length : 0,
            );
          }).toList())
    ];
  }
}
