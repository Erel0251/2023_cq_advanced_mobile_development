import 'package:flutter/material.dart';
import 'package:test_route/widgets/button.dart';

class Pagination extends StatelessWidget {
  const Pagination(this.total, {this.current = 1, super.key});

  final int total;
  final int current;

  Color isCurrent(int i) {
    if (i == current) {
      return Colors.blue;
    } else {
      return Colors.black;
    }
  }

  Color isStart() {
    if (current == 1) {
      return Colors.black38;
    } else {
      return Colors.black;
    }
  }

  Color isEnd() {
    if (current == total) {
      return Colors.black38;
    } else {
      return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SquareButton(
          color: isStart(),
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: isStart(),
            size: 16,
          ),
        ),
        for (int i = 1; i <= total; i++)
          SquareButton(
            color: isCurrent(i),
            child: Text(
              i.toString(),
              style: TextStyle(
                fontSize: 16,
                color: isCurrent(i),
              ),
            ),
          ),
        SquareButton(
          color: isEnd(),
          child: Icon(
            Icons.arrow_forward_ios_rounded,
            color: isEnd(),
            size: 16,
          ),
        ),
      ],
    );
  }
}
