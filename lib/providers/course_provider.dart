import 'package:flutter/material.dart';
import 'package:let_tutor_app/controllers/course_controller.dart';
import 'package:let_tutor_app/models/course/response_courses.dart';

class CoursesFilterProvider with ChangeNotifier {
  List<int> _level = [];
  final List<String> _category = [];
  String _sort = '';
  String _query = '';
  String _type = 'course';

  List<int> get level => _level;
  List<String> get category => _category;
  String get query => _query;
  String get sort => _sort;
  String get type => _type;

  void setLevel(int level) {
    if (_level.contains(level)) {
      _level.remove(level);
    } else {
      _level.add(level);
    }
    if (level == 0) {
      _level = [];
    }
    notifyListeners();
  }

  void setCategory(String category) {
    if (_category.contains(category)) {
      _category.remove(category);
    } else {
      _category.add(category);
    }
    notifyListeners();
  }

  void setSort(String sort) {
    _sort = sort;
    notifyListeners();
  }

  void setQuery(String query) {
    _query = query;
    notifyListeners();
  }

  void setType(String type) {
    _type = type;
    notifyListeners();
  }

  void checkTypeFilter(String hint, dynamic value) {
    switch (hint) {
      case 'Select level':
        setLevel(value);
        break;
      case 'Select category':
        setCategory('');
        break;
      case 'Sort by level':
        setSort(value.toString());
        break;
    }
  }

  Future<ListCourses> filterCourses() {
    return fetchCourses(
      levels: _level,
      //categories: _category,
      //sort: _sort,
      query: _query,
      type: _type,
    );
  }
}
