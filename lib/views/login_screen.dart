import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test_route/controllers/login_action.dart';

import 'package:test_route/utils/valid_input.dart';
import 'package:test_route/widgets/button.dart';
import 'package:test_route/models/authentication/resonse_login.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  final String title1 = 'Say hello to your English tutors';
  final String title2 =
      'Become fluent faster through one on one video chat lessons tailored to your goals.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 30),
        children: [
          Image.asset('assets/images/login.8d01124a.png'),
          ...buildBanner(),
          FormInput(),
          _signUp(context),
        ],
      ),
    );
  }

  // Appbar widget
  AppBar _appBar() {
    return AppBar(
      toolbarHeight: 70,
      backgroundColor: Colors.white,
      title: SvgPicture.asset(
        'assets/images/lettutor_logo.svg',
        width: 150.0,
        fit: BoxFit.fitWidth,
      ),
      actions: const <Widget>[LanguageButton()],
    );
  }

  // Banner widget
  List<Widget> buildBanner() {
    return <Widget>[
      Text(
        title1,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Color.fromRGBO(0, 113, 240, 1),
          fontSize: 28,
          overflow: TextOverflow.clip,
        ),
      ),
      Text(
        title2,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Color.fromRGBO(42, 52, 83, 1),
          fontSize: 16,
          overflow: TextOverflow.clip,
        ),
      ),
    ];
  }

  Widget _signUp(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Not a member yet? ',
          style: TextStyle(
            height: 3,
            fontSize: 14,
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
              (Route<dynamic> route) => false,
            );
          },
          child: const Text(
            'Sign up',
            style: TextStyle(
              height: 3,
              fontSize: 14,
              color: Color.fromRGBO(40, 106, 210, 1),
            ),
          ),
        ),
      ],
    );
  }
}

class FormInput extends StatelessWidget {
  // constructor with 1 optional parameter as login or signup
  FormInput({super.key, this.type = 'log in'});

  final String type;
  // valid input email
  final TextEditingController _usernameController = TextEditingController();
  // valid input password
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Login fields
        ...loginSection(),
        // Password fields
        ...passwordSection(),
        // Forgot password
        textTitle(
            title: 'Forgot password?',
            color: const Color.fromRGBO(40, 106, 210, 1)),
        // Widget login button with logic check logic and exist email and password
        ElevatedButton(
          onPressed: () async {
            // Logic check input valid email and password
            if (validEmail(_usernameController.text) &&
                validPassword(_passwordController.text)) {
              try {
                // Get response from server
                final User user = await fetchLogin(
                    _usernameController.text, _passwordController.text);
                // Navigate to home screen
              } catch (e) {
                // Show error message
              }
            }
          },
          child: Text(
            type.toUpperCase(),
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
        const Text(
          'Or continue with',
          textAlign: TextAlign.center,
          style: TextStyle(
            height: 2,
            fontSize: 16,
          ),
        ),
        // Social login
        countinueWith(),
      ],
    );
  }

  // Widgets signin with socials or android
  Widget countinueWith() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // Facebook login
        IconButton(
          onPressed: () {},
          iconSize: 50.0,
          icon: SvgPicture.asset(
            'assets/images/facebook-logo.3bac8064.svg',
            allowDrawingOutsideViewBox: true,
          ),
        ),
        // Google login
        IconButton(
          onPressed: () {},
          iconSize: 50.0,
          icon: SvgPicture.asset('assets/images/google-logo.5f53496e.svg'),
        ),
        // Android login
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(60)),
            border: Border.all(
              color: Colors.blue,
            ),
          ),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.ad_units_rounded),
          ),
        ),
      ],
    );
  }

  // Login title and field
  List<Widget> loginSection() {
    return [
      textTitle(title: 'Login'),
      // Login text form with logic check input valid Email
      TextFormField(
        controller: _usernameController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: "email",
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your email';
          }
          return null;
        },
      ),
    ];
  }

  // Password title and field
  List<Widget> passwordSection() {
    return [
      textTitle(title: 'Password'),
      // Password input field with hide characters and logic check input valid password
      TextFormField(
        controller: _passwordController,
        obscureText: true,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: "password",
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your password';
          }
          return null;
        },
      ),
    ];
  }

  // text title and color, avoid duplicate code
  Widget textTitle(
      {required String title,
      Color? color = const Color.fromRGBO(164, 176, 190, 1)}) {
    return Text(
      title,
      style: TextStyle(
        height: 3,
        fontSize: 13,
        color: color,
      ),
    );
  }
}

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  final String title1 = 'Say hello to your English tutors';
  final String title2 =
      'Become fluent faster through one on one video chat lessons tailored to your goals.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 30),
        children: [
          Image.asset('assets/images/login.8d01124a.png'),
          ...buildBanner(),
          FormInput(type: 'sign up'),
          _login(context),
        ],
      ),
    );
  }

  // Appbar widget
  AppBar _appBar() {
    return AppBar(
      toolbarHeight: 70,
      backgroundColor: Colors.white,
      title: SvgPicture.asset(
        'assets/images/lettutor_logo.svg',
        width: 150.0,
        fit: BoxFit.fitWidth,
      ),
      actions: const <Widget>[LanguageButton()],
    );
  }

  // Banner widget
  List<Widget> buildBanner() {
    return <Widget>[
      Text(
        title1,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Color.fromRGBO(0, 113, 240, 1),
          fontSize: 28,
          overflow: TextOverflow.clip,
        ),
      ),
      Text(
        title2,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Color.fromRGBO(42, 52, 83, 1),
          fontSize: 16,
          overflow: TextOverflow.clip,
        ),
      ),
    ];
  }

  Widget _login(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Already have an account? ',
          style: TextStyle(
            height: 3,
            fontSize: 14,
          ),
        ),
        // link navigate to login screen
        GestureDetector(
          onTap: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
              (Route<dynamic> route) => false,
            );
          },
          child: const Text(
            'Log in',
            style: TextStyle(
              height: 3,
              fontSize: 14,
              color: Color.fromRGBO(40, 106, 210, 1),
            ),
          ),
        ),
      ],
    );
  }
}
