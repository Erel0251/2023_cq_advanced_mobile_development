import 'package:flutter/material.dart';
import 'package:let_tutor_app/providers/tutor_provider.dart';
import 'package:let_tutor_app/widgets/button.dart';
import 'package:provider/provider.dart';

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

    Widget buttonDot() {
      return const SquareButton(
        child: Text(
          '...',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      );
    }

    Widget buttonPage(int i) {
      return GestureDetector(
        onTap: () => context.read<TutorProvider>().setPage(i),
        child: SquareButton(
          color: isChosen(i),
          child: Text(
            (i).toString(),
            style: TextStyle(
              fontSize: 16,
              color: isChosen(i),
            ),
          ),
        ),
      );
    }

    Widget buttonBackward() {
      return GestureDetector(
        onTap: () {
          if (current > 1) {
            context.read<TutorProvider>().setPage(current - 1);
          }
        },
        child: SquareButton(
          color: isBlocked(1),
          child: Icon(
            Icons.arrow_back_ios_rounded,
            color: isBlocked(1),
            size: 16,
          ),
        ),
      );
    }

    Widget buttonForward() {
      return GestureDetector(
        onTap: () {
          if (current < numsPage) {
            context.read<TutorProvider>().setPage(current + 1);
          }
        },
        child: SquareButton(
          color: isBlocked((total ~/ itemPerPage).ceil()),
          child: Icon(
            Icons.arrow_forward_ios_rounded,
            color: isBlocked((total ~/ itemPerPage).ceil()),
            size: 16,
          ),
        ),
      );
    }

    List<Widget> normalCase() {
      List<Widget> pages = [];
      for (int i = 1; i <= numsPage; i++) {
        pages.add(buttonPage(i));
      }
      return pages;
    }

    List<Widget> overflowCase() {
      List<Widget> pages = [];

      pages.add(buttonPage(1));
      if (current <= 3) {
        // if current page is in the first 3 pages
        // it will show as < 1 2 3 ... 10 >
        pages.add(buttonPage(2));
        pages.add(buttonPage(3));
        pages.add(buttonDot());
      } else if (current >= numsPage - 2) {
        // if current page is in the last 3 pages
        // it will show as < 1 ... 8 9 10 >
        pages.add(buttonDot());
        pages.add(buttonPage(numsPage - 2));
        pages.add(buttonPage(numsPage - 1));
      } else {
        // if current page is in the middle
        // it will show as < 1 ... 5 6 7 ... 10 >
        pages.add(buttonDot());
        pages.add(buttonPage(current - 1));
        pages.add(buttonPage(current));
        pages.add(buttonPage(current + 1));
        pages.add(buttonDot());
      }
      pages.add(buttonPage(numsPage));
      return pages;
    }

    return Row(
      children: [
        buttonBackward(),
        if (numsPage <= 5) ...normalCase() else ...overflowCase(),
        buttonForward(),
      ],
    );
  }
}
