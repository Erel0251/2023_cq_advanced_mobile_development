import 'package:flutter/material.dart';
import 'package:let_tutor_app/widgets/button.dart';

class Pagination extends StatelessWidget {
  const Pagination(this.total, {this.current = 1, super.key});

  // total mean total item, current mean current pages
  // default is 10 item per page
  final int total;
  final int current;

  Color isBlocked(int i, int blockValue) {
    if (i == blockValue) {
      return Colors.black38;
    } else {
      return Colors.black;
    }
  }

  // This pagination will be used as part of provider package,
  // so it will be updated when the current page is changed
  // and the total item is changed
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _buttonBackward(),
        for (int i = 1; i <= ((total as double) / 10).ceil(); i++)
          _buttonPage(i),
        _buttonForward(),
      ],
    );
  }

  Widget _buttonPage(int i) {
    return SquareButton(
      color: isBlocked(i, current),
      child: Text(
        i.toString(),
        style: TextStyle(
          fontSize: 16,
          color: isBlocked(i, current),
        ),
      ),
    );
  }

  Widget _buttonBackward() {
    return SquareButton(
      color: isBlocked(1, current),
      child: Icon(
        Icons.arrow_back_ios_new_rounded,
        color: isBlocked(1, current),
        size: 16,
      ),
    );
  }

  Widget _buttonForward() {
    return SquareButton(
      color: isBlocked(((total as double) / 10).ceil(), current),
      child: Icon(
        Icons.arrow_forward_ios_rounded,
        color: isBlocked(((total as double) / 10).ceil(), current),
        size: 16,
      ),
    );
  }
}

// provider package will be used to update the current page
class PaginationProvider extends ChangeNotifier {
  int _currentPage = 1;
  int _total = 0;

  int get currentPage => _currentPage;
  int get total => _total;

  void updateCurrentPage(int page) {
    _currentPage = page;
    notifyListeners();
  }

  void updateTotal(int total) {
    _total = total;
    notifyListeners();
  }
}
