import 'package:flutter/material.dart';
import 'package:let_tutor_app/widgets/button.dart';

// TODO: This pagination is not finished yet
// it need provider package to update the current page

class Pagination extends StatelessWidget {
  const Pagination(
    this.total, {
    this.current = 1,
    this.itemPerPage = 10,
    super.key,
  });

  // total mean total item, current mean current pages
  // default is 10 item per page
  final int total;
  final int current;
  final int itemPerPage;

  Color isBlocked(int i) {
    if (i == current) {
      return Colors.black38;
    } else {
      return Colors.black;
    }
  }

  Color isChosen(int i) {
    if (i == current) {
      return Colors.blueAccent;
    } else {
      return Colors.black;
    }
  }

  // This pagination will be used as part of provider package,
  // so it will be updated when the current page is changed
  // and the total item is changed
  @override
  Widget build(BuildContext context) {
    int numsPage = (total / itemPerPage).ceil();

    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        _buttonBackward(),
        if (numsPage <= 5)
          ..._normalCase(numsPage)
        else
          ..._overflowCase(numsPage),
        _buttonForward(),
      ],
    );
  }

  List<Widget> _normalCase(int numsPage) {
    List<Widget> pages = [];
    for (int i = 1; i <= numsPage; i++) {
      pages.add(_buttonPage(i));
    }
    return pages;
  }

  List<Widget> _overflowCase(int numsPage) {
    List<Widget> pages = [];
    pages.add(_buttonPage(1));
    pages.add(_buttonDot());
    for (int i = current - 1; i <= current + 1; i++) {
      pages.add(_buttonPage(i));
    }
    pages.add(_buttonDot());
    pages.add(_buttonPage(numsPage));
    return pages;
  }

  Widget _buttonDot() {
    return const SquareButton(
      color: Colors.black,
      child: Text(
        '...',
        style: TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buttonPage(int i) {
    return SquareButton(
      color: isChosen(i),
      child: Text(
        (i).toString(),
        style: TextStyle(
          fontSize: 16,
          color: isChosen(i),
        ),
      ),
    );
  }

  Widget _buttonBackward() {
    return SquareButton(
      color: isBlocked(1),
      child: Icon(
        Icons.arrow_back_ios_new_rounded,
        color: isBlocked(1),
        size: 16,
      ),
    );
  }

  Widget _buttonForward() {
    return SquareButton(
      color: isBlocked((total ~/ itemPerPage).ceil()),
      child: Icon(
        Icons.arrow_forward_ios_rounded,
        color: isBlocked((total ~/ itemPerPage).ceil()),
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
