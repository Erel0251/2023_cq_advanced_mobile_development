import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test_route/widgets/button.dart';
import 'package:test_route/widgets/footer.dart';

class MainBody extends StatelessWidget {
  const MainBody(this.child, {super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.white,
        title: SvgPicture.asset(
          'assets/images/lettutor_logo.svg',
          width: 150.0,
          fit: BoxFit.fitWidth,
        ),
        actions: const <Widget>[
          LanguageButton(),
          MenuButton(),
        ],
      ),
      body: ListView(
        children: [
          child,
          const Footer(),
        ],
      ),
      floatingActionButton: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: <Widget>[
          FloatingActionButton(
            backgroundColor: const Color.fromRGBO(128, 128, 128, 1),
            onPressed: () {},
            child: const Icon(Icons.chat_outlined),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 80),
            child: FloatingActionButton(
              backgroundColor: const Color.fromRGBO(128, 128, 128, 1),
              onPressed: () {},
              child: const Icon(Icons.card_giftcard),
            ),
          ),
        ],
      ),
    );
  }
}
