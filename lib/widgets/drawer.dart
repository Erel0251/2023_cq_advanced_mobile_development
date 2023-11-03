import 'package:flutter/material.dart';
import 'package:test_route/views/booking_screen.dart';

class DrawerOnly extends StatelessWidget {
  const DrawerOnly({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 99),
      child: Drawer(
        width: double.maxFinite,
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.verified_user),
              title: const Text(
                "Phhai",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Container()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.verified_user),
              title: const Text(
                "Recurring Lesson Schedule",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.verified_user),
              title: const Text(
                "Tutor",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.verified_user),
              title: const Text(
                "Schedule",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                //Route route = MaterialPageRoute(
                //    builder: (context) => const BookingScreen());
                //Navigator.pushReplacement(context, route);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const BookingScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text(
                "History",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.verified_user),
              title: const Text(
                "Courses",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.verified_user),
              title: const Text(
                "My Course",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.verified_user),
              title: const Text(
                "Become a tutor",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.verified_user),
              title: const Text(
                "Logout",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
