import 'package:flutter/material.dart';
import 'package:flag/flag.dart';

class LanguageButton extends StatelessWidget {
  const LanguageButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showMenu(
          context: context,
          position: const RelativeRect.fromLTRB(5, 100, 0, 0),
          items: const [
            PopupMenuItem(
              value: 'English',
              child: Row(
                children: [
                  Flag.fromString(
                    'US',
                    width: 30,
                    height: 30,
                    flagSize: FlagSize.size_1x1,
                  ),
                  Text(' English')
                ],
              ),
            ),
            PopupMenuItem(
              value: 'Vietnamese',
              child: Row(
                children: [
                  Flag.fromString(
                    'VN',
                    width: 30,
                    height: 30,
                    flagSize: FlagSize.size_1x1,
                  ),
                  Text(' Vietnamese')
                ],
              ),
            ),
          ],
          elevation: 8.0,
        ).then((value) {
          if (value != null) {
            //print('Selected: $value');
          }
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 15),
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black12,
        ),
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: const Flag.fromString(
            'US',
            width: 25,
            height: 25,
            flagSize: FlagSize.size_1x1,
          ),
        ),
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  const MenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Scaffold.of(context).openEndDrawer();
      },
      child: Container(
        margin: const EdgeInsets.only(right: 15),
        padding: const EdgeInsets.all(8.0),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black12,
        ),
        child: const Icon(
          Icons.list_rounded,
          color: Colors.black,
        ),
      ),
    );
  }
}

class TagFilter extends StatelessWidget {
  const TagFilter(this.text, {this.isChecked = false, super.key});
  final String text;
  final bool isChecked;

  Color getTextColor() {
    if (isChecked) {
      return const Color.fromARGB(255, 0, 113, 240);
    } else {
      return Colors.black87;
    }
  }

  Color getBoxColor() {
    if (isChecked) {
      return const Color.fromARGB(255, 221, 234, 255);
    } else {
      return const Color.fromRGBO(228, 230, 235, 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        color: getBoxColor(),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 12, color: getTextColor()),
      ),
    );
  }
}

class ResetFilterButton extends StatelessWidget {
  const ResetFilterButton(this.text, {super.key, this.onPressed});
  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        margin: const EdgeInsets.all(5),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          color: Color.fromRGBO(228, 230, 235, 1),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 12, color: Colors.black87),
        ),
      ),
    );
  }
}

class SquareButton extends StatelessWidget {
  const SquareButton({
    required this.child,
    this.edge = 30,
    this.active = false,
    this.color = Colors.black,
    super.key,
  });

  final Widget child;
  final double edge;
  final bool active;
  final Color color;

  Color isActive() {
    if (active) {
      return Colors.blue;
    } else {
      return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: edge,
      height: edge,
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(color: color),
        color: Colors.white,
      ),
      child: child,
    );
  }
}

class FloatButtons extends StatelessWidget {
  const FloatButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: <Widget>[
        FloatingActionButton(
          heroTag: null,
          backgroundColor: const Color.fromRGBO(128, 128, 128, 1),
          onPressed: () {},
          child: const Icon(Icons.chat_outlined),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 80),
          child: FloatingActionButton(
            heroTag: null,
            backgroundColor: const Color.fromRGBO(128, 128, 128, 1),
            onPressed: () {},
            child: const Icon(Icons.card_giftcard),
          ),
        ),
      ],
    );
  }
}
