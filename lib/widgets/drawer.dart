import 'package:flutter/material.dart';
import 'package:let_tutor_app/views/schedule_screen.dart';
import 'package:let_tutor_app/views/courses/courses_screen.dart';
import 'package:let_tutor_app/views/history_screen.dart';

// TODO: add navigation to other screens
class DrawerOnly extends StatelessWidget {
  const DrawerOnly({super.key});

  void _popDrawer(BuildContext context) {
    Navigator.pop(context);
  }

  void _pushSchedule(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ScheduleScreen()),
    );
  }

  void _pushHistory(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HistoryScreen()),
    );
  }

  void _pushCourses(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CoursesScreen()),
    );
  }

  void _logout(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 90),
      child: Drawer(
        width: double.maxFinite,
        child: ListView(
          children: [
            _head(context),
            _listTile(
              "Recurring Lesson Schedule",
              Icons.calendar_today_outlined,
            ),
            _listTile(
              "Tutor",
              Icons.contacts_outlined,
            ),
            _listTile(
              "Schedule",
              Icons.calendar_month,
            ),
            _listTile(
              "History",
              Icons.history,
            ),
            _listTile(
              "Courses",
              Icons.school_outlined,
            ),
            _listTile(
              "My Course",
              Icons.menu_book_outlined,
            ),
            _listTile(
              "Become a tutor",
              Icons.image_not_supported_outlined,
            ),
            _listTile(
              "Logout",
              Icons.logout_outlined,
            ),
          ],
        ),
      ),
    );
  }

  Widget _head(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 38,
        height: 38,
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: Image.asset(
          'assets/images/avatar03.jpeg',
          fit: BoxFit.cover,
        ),
      ),
      title: const Text(
        "Phhai",
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }

  Widget _listTile(String title, IconData icon) {
    return ListTile(
      leading: SizedBox(
          width: 38,
          height: 38,
          child: Icon(
            icon,
            color: Colors.blue,
          )),
      title: Text(
        title,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
      onTap: () {},
    );
  }
}
