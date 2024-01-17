import 'package:flutter/material.dart';
import 'package:let_tutor_app/views/schedule_screen.dart';
import 'package:let_tutor_app/views/courses_screen.dart';
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
            ListTile(
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
            ),
            ListTile(
              leading: const SizedBox(
                width: 38,
                height: 38,
                child: Icon(
                  Icons.calendar_today_outlined,
                  color: Colors.blue,
                ),
              ),
              title: const Text(
                "Recurring Lesson Schedule",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const SizedBox(
                width: 38,
                height: 38,
                child: Icon(
                  Icons.contacts_outlined,
                  color: Colors.blue,
                ),
              ),
              title: const Text(
                "Tutor",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const SizedBox(
                width: 38,
                height: 38,
                child: Icon(
                  Icons.calendar_month,
                  color: Colors.blue,
                ),
              ),
              title: const Text(
                "Schedule",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ScheduleScreen()),
                );
              },
            ),
            ListTile(
              leading: const SizedBox(
                width: 38,
                height: 38,
                child: Icon(
                  Icons.history,
                  color: Colors.blue,
                ),
              ),
              title: const Text(
                "History",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HistoryScreen()),
                );
              },
            ),
            ListTile(
              leading: const SizedBox(
                width: 38,
                height: 38,
                child: Icon(
                  Icons.school_outlined,
                  color: Colors.blue,
                ),
              ),
              title: const Text(
                "Courses",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CoursesScreen()),
                );
              },
            ),
            ListTile(
              leading: const SizedBox(
                width: 38,
                height: 38,
                child: Icon(
                  Icons.menu_book_outlined,
                  color: Colors.blue,
                ),
              ),
              title: const Text(
                "My Course",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const SizedBox(
                width: 38,
                height: 38,
                child: Icon(
                  Icons.image_not_supported_outlined,
                  color: Colors.blue,
                ),
              ),
              title: const Text(
                "Become a tutor",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const SizedBox(
                width: 38,
                height: 38,
                child: Icon(
                  Icons.logout_outlined,
                  color: Colors.blue,
                ),
              ),
              title: const Text(
                "Logout",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
          ],
        ),
      ),
    );
  }
}
