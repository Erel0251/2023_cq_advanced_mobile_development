import 'package:flutter/material.dart';
import 'package:flag/flag.dart';
import 'package:let_tutor_app/controllers/tutor_controller.dart';

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

// Multiple choice button options dropdown
class MultipleChoiceButton extends StatefulWidget {
  const MultipleChoiceButton({
    required this.options,
    required this.onChanged,
    this.active = false,
    super.key,
  });

  final List<String> options;
  final Function(String) onChanged;
  final bool active;

  @override
  _MultipleChoiceButtonState createState() => _MultipleChoiceButtonState();
}

class _MultipleChoiceButtonState extends State<MultipleChoiceButton> {
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        color: widget.active
            ? const Color.fromRGBO(228, 230, 235, 1)
            : Colors.transparent,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedOption,
          icon: const Icon(Icons.keyboard_arrow_down),
          iconSize: 24,
          elevation: 16,
          style: const TextStyle(color: Colors.black87),
          onChanged: (String? newValue) {
            setState(() {
              _selectedOption = newValue;
            });
            widget.onChanged(newValue!);
          },
          items: widget.options.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class FavoriteButton extends StatefulWidget {
  const FavoriteButton(this.tutorId, {super.key});
  final String tutorId;

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await addTutorToFavorite(widget.tutorId);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Added tutor to favorite')),
          );
        }
        setState(() {
          isLiked = !isLiked;
        });
      },
      child: Column(
        children: [
          Icon(
            isLiked ? Icons.favorite : Icons.favorite_outline_rounded,
            color: isLiked ? Colors.redAccent : Colors.blue,
          ),
          Text(
            'Favorite',
            style: TextStyle(color: isLiked ? Colors.redAccent : Colors.blue),
          ),
        ],
      ),
    );
  }
}

class ReportButton extends StatelessWidget {
  const ReportButton(this.tutorId, this.nameTutor, {super.key});
  final String nameTutor;
  final String tutorId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: const Column(
        children: [
          Icon(
            Icons.info_outline_rounded,
            color: Colors.blue,
          ),
          Text(
            'Report',
            style: TextStyle(color: Colors.blue),
          ),
        ],
      ),
      // popup report form dialog
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: _titleDialog(),
            content: _formReport(),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, 'Submit'),
                child: const Text('Submit'),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _titleDialog() {
    return Text(
      'Report $nameTutor',
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _formReport() {
    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // horizontal line
          const Divider(thickness: 1),
          // little header
          const Text(
            "Help us understand what's happening",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          // Checkbox button and description about reason report
          const CheckBoxReasonReport('This tutor is annoying me'),
          const CheckBoxReasonReport(
              'This profile is pretending be someone or is fake'),
          const CheckBoxReasonReport('Inappropriate profile photo'),
          // Textfield for more detail
          _textFormField(),
        ],
      ),
    );
  }

  TextFormField _textFormField() {
    return TextFormField(
      decoration: const InputDecoration(
        hintText: 'Please let us know details about your problem',
        border: OutlineInputBorder(),
      ),
      maxLines: 3,
    );
  }
}

class CheckBoxReasonReport extends StatefulWidget {
  const CheckBoxReasonReport(this.reason, {super.key});
  final String reason;

  @override
  State<CheckBoxReasonReport> createState() => _CheckBoxReasonReportState();
}

class _CheckBoxReasonReportState extends State<CheckBoxReasonReport> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: isChecked,
          onChanged: (value) {
            setState(() {
              isChecked = value!;
            });
          },
        ),
        // wrap text if it's too long
        Expanded(
          child: Text(
            widget.reason,
            overflow: TextOverflow.visible,
          ),
        ),
      ],
    );
  }
}
