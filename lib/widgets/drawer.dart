import 'package:flutter/material.dart';
import 'package:let_tutor_app/views/schedule_screen.dart';
import 'package:let_tutor_app/views/courses/courses_screen.dart';
import 'package:let_tutor_app/views/history_screen.dart';

class DrawerOnly extends StatelessWidget {
  const DrawerOnly({super.key});

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
              () => Navigator.pop(context),
            ),
            _listTile(
              "Tutor",
              Icons.contacts_outlined,
              () => Navigator.pop(context),
            ),
            _listTile(
              "Schedule",
              Icons.calendar_month,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ScheduleScreen()),
              ),
            ),
            _listTile(
              "History",
              Icons.history,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HistoryScreen()),
              ),
            ),
            _listTile(
              "Courses",
              Icons.school_outlined,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CoursesScreen()),
              ),
            ),
            _listTile(
              "My Course",
              Icons.menu_book_outlined,
              () => Navigator.pop(context),
            ),
            _listTile(
              "Become a tutor",
              Icons.image_not_supported_outlined,
              () => Navigator.pop(context),
            ),
            _listTile(
              "Logout",
              Icons.logout_outlined,
              () => Navigator.of(context).popUntil((route) => route.isFirst),
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

  Widget _listTile(
    String title,
    IconData icon,
    Function onTap,
  ) {
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
      onTap: onTap(),
    );
  }
}
