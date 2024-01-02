import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test_route/views/home_screen.dart';
import 'package:test_route/widgets/button.dart';
import 'package:test_route/widgets/drawer.dart';
import 'package:test_route/widgets/footer.dart';

class MainBody extends StatelessWidget {
  const MainBody(this.child, {super.key, this.containFooter = true});

  final Widget child;
  final bool containFooter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      drawerScrimColor: Colors.transparent,
      endDrawer: const DrawerOnly(),
      body: ListView(
        children: [
          child,
          if (containFooter) const Footer(),
        ],
      ),
      floatingActionButton: const FloatButtons(),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 70,
      backgroundColor: Colors.white,
      title: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        },
        child: SvgPicture.asset(
          'assets/images/lettutor_logo.svg',
          width: 150.0,
          fit: BoxFit.fitWidth,
        ),
      ),
      actions: const <Widget>[
        LanguageButton(),
        MenuButton(),
      ],
    );
  }
}
