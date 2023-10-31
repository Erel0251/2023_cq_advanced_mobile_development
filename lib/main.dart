import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'views/login_screen.dart'; // 1 90% password
import 'views/home_screen.dart'; // 2 80% menu list item
import 'views/tutor_screen.dart'; // 3 70% table
import 'views/booking_screen.dart'; // 4 85% need Date row and implement class
import 'views/history_screen.dart'; // 5 95% dropdown Request and Review
import 'views/courses_screen.dart'; //6 95%
import 'views/course_info_screen.dart'; // 7 100%
import 'views/course_detail_screen.dart'; //8
import 'views/call_screen.dart'; //9

void main() {
  runApp(const MaterialApp(
    home: CourseInfoScreen(),
  ));
}
