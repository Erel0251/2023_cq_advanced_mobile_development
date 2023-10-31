import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'views/login_screen.dart'; // 1 90% password
import 'views/home_screen.dart'; // 2 80% menu list item
import 'views/tutor_screen.dart'; // 3 70% table
import 'views/courses_screen.dart'; //7
import 'views/course_info_screen.dart'; // 8
import 'views/explore_course_screen.dart'; //6
import 'views/history_screen.dart'; // 5 95% dropdown Request and Review
import 'views/call_screen.dart'; //9
import 'views/booking_screen.dart'; // 4 85% need Date row and implement class

void main() {
  runApp(const MaterialApp(
    home: HistoryScreen(),
  ));
}
