import 'package:flutter/material.dart';
import 'package:let_tutor_app/views/lessons/schedule_screen.dart';
import 'package:let_tutor_app/views/courses/courses_screen.dart';
import 'package:let_tutor_app/views/lessons/history_screen.dart';
import 'package:let_tutor_app/views/home_screen.dart';
import 'package:let_tutor_app/views/user/setting_screen.dart';

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

  void _pushHome(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  void _pushUserSetting(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SettingScreen()),
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
              context,
              "Recurring Lesson Schedule",
              Icons.calendar_today_outlined,
            ),
            _listTile(
              context,
              "Tutor",
              Icons.contacts_outlined,
            ),
            _listTile(
              context,
              "Schedule",
              Icons.calendar_month,
            ),
            _listTile(
              context,
              "History",
              Icons.history,
            ),
            _listTile(
              context,
              "Courses",
              Icons.school_outlined,
            ),
            _listTile(
              context,
              "My Course",
              Icons.menu_book_outlined,
            ),
            _listTile(
              context,
              "Become a tutor",
              Icons.image_not_supported_outlined,
            ),
            _listTile(
              context,
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
        _pushUserSetting(context);
      },
    );
  }

  Widget _listTile(BuildContext context, String title, IconData icon) {
    void _onTap() {
      switch (title) {
        case "Tutor":
          _pushHome(context);
          break;
        case "Schedule":
          _pushSchedule(context);
          break;
        case "History":
          _pushHistory(context);
          break;
        case "Courses":
          _pushCourses(context);
          break;
        case "Logout":
          _logout(context);
          break;
        default:
          _popDrawer(context);
          break;
      }
    }

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
      onTap: _onTap,
    );
  }
}
