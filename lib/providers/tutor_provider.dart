import 'package:flutter/material.dart';
import 'package:let_tutor_app/controllers/tutor_controller.dart';
import 'package:let_tutor_app/models/tutor/response_search.dart';

class TutorProvider extends ChangeNotifier {
  int _page = 1;
  int _size = 10;
  String _search = '';
  final List<String> _nationality = [];
  String _specialties = '';

  int get page => _page;
  int get size => _size;
  String get search => _search;
  List<String> get nationaltity => _nationality;

  void setPage(int page) {
    _page = page;
    notifyListeners();
  }

  void setSize(int size) {
    _size = size;
    notifyListeners();
  }

  void setSearch(String search) {
    _search = search;
    notifyListeners();
  }

  void setNationality(List<String> value) {
    _nationality.clear();
    _nationality.addAll(value);
    notifyListeners();
  }

  void setSpecialties(String specialties) {
    _specialties = specialties;
    notifyListeners();
  }

  void clear() {
    _page = 1;
    _size = 10;
    _search = '';
    _nationality.clear();
    _specialties = '';
    notifyListeners();
  }

  Future<ResponseSearchTutor> filterTutors() {
    return searchTutorsInfo(
      page: _page,
      perPage: _size,
      search: _search,
      nationality: _nationality,
      specialties: _specialties,
    );
  }
}
