import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'views/login_screen.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(), // home has implicit route set at '/'
  ));
}
