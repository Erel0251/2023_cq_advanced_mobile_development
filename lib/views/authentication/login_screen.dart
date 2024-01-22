import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:let_tutor_app/controllers/authentication_controller.dart';
import 'package:let_tutor_app/views/tutor/home_screen.dart';
import 'package:let_tutor_app/widgets/button.dart';

// TODO: need google and facebook authentication
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final String title1 = 'Say hello to your English tutors';

  final String title2 =
      'Become fluent faster through one on one video chat lessons tailored to your goals.';

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: ListView(
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 30),
        children: [
          Image.asset('assets/images/login.8d01124a.png'),
          ...buildBanner(),
          AuthenFormInput(_scrollController),
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
}

class AuthenFormInput extends StatefulWidget {
  // constructor with 1 optional parameter as login or signup
  const AuthenFormInput(this.scrollController, {super.key});

  final ScrollController scrollController;

  @override
  State<AuthenFormInput> createState() => _AuthenFormInputState();
}

class _AuthenFormInputState extends State<AuthenFormInput> {
  // type of form
  bool isUsingEmail = true;
  String type = 'log in';

  // valid input email
  TextEditingController usernameController = TextEditingController();

  // valid input password
  TextEditingController passwordController = TextEditingController();

  Future<void> handleAuthentication(BuildContext context) async {
    try {
      // depend on type and input, call function login or signup for email or phone
      Future<void> Function(String, String) handle = type == 'log in'
          ? (isUsingEmail ? loginWithEmail : loginWithPhone)
          : (isUsingEmail ? registerWithEmail : registerWithPhone);

      await handle(
        usernameController.text,
        passwordController.text,
      );

      // Navigate to home screen when authenticate success
      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    } catch (e) {
      // Show error message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred: $e')),
        );
      }
      // reload page
      setState(() {
        usernameController.text = '';
        passwordController.text = '';
        widget.scrollController.animateTo(
          0.0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

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
        isUsingEmail ? _forgotPassword(context) : const SizedBox(height: 38),
        // Widget login button with logic check logic and exist email and password
        buttonAuthen(),
        textNavigate('or continue with'),
        // Social login
        countinueWith(),
        _changeType(context),
      ],
    );
  }

  // Login title and field
  List<Widget> loginSection() {
    return [
      textTitle(title: type == 'log in' ? 'Log in' : 'Sign up'),
      // Login text form with logic check input valid Email
      TextFormField(
        controller: usernameController,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: isUsingEmail ? "email" : "phone",
          hintStyle: const TextStyle(
            color: Color.fromRGBO(164, 176, 190, 1),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return isUsingEmail
                ? 'Please enter your email'
                : 'Please enter your phone';
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
        controller: passwordController,
        obscureText: true,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: "password",
          hintStyle: TextStyle(
            color: Color.fromRGBO(164, 176, 190, 1),
          ),
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

  Widget _forgotPassword(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ForgotPasswordScreen(),
        ),
      ),
      child: textTitle(
          title: 'Forgot password?',
          color: const Color.fromRGBO(40, 106, 210, 1)),
    );
  }

  // Logic button login or signup
  Widget buttonAuthen() {
    return ElevatedButton(
      onPressed: () => handleAuthentication(context),
      child: Text(
        type.toUpperCase(),
        style: const TextStyle(
          fontSize: 20,
          //color: Colors.white,
        ),
      ),
    );
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

  Widget textNavigate(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
        height: 2,
        fontSize: 16,
      ),
    );
  }

  // Widgets signin with socials or android
  Widget countinueWith() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // Facebook login
        _facebookIcon(),
        // Google login
        _googleIcon(),
        isUsingEmail ? _androidIcon() : _emailIcon(),
      ],
    );
  }

  Widget _facebookIcon() {
    return IconButton(
      onPressed: () {},
      iconSize: 50.0,
      icon: SvgPicture.asset(
        'assets/images/facebook-logo.3bac8064.svg',
        allowDrawingOutsideViewBox: true,
      ),
    );
  }

  Widget _googleIcon() {
    return IconButton(
      onPressed: () {},
      iconSize: 50.0,
      icon: SvgPicture.asset('assets/images/google-logo.5f53496e.svg'),
    );
  }

  Widget _androidIcon() {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(60)),
        border: Border.all(
          color: Colors.blue,
        ),
      ),
      child: IconButton(
        onPressed: () {
          setState(() {
            isUsingEmail = false;
            type = 'log in';
            widget.scrollController.animateTo(
              0.0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          });
        },
        icon: const Icon(Icons.ad_units_rounded),
      ),
    );
  }

  Widget _emailIcon() {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(60)),
        border: Border.all(
          color: Colors.blue,
        ),
      ),
      child: IconButton(
        onPressed: () {
          setState(() {
            isUsingEmail = true;
            type = 'log in';

            widget.scrollController.animateTo(
              0.0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          });
        },
        icon: const Icon(Icons.email_outlined),
      ),
    );
  }

  Widget _changeType(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        type == 'log in'
            ? _text('Not a member yet? ')
            : _text('Already have an account? '),
        GestureDetector(
          onTap: () {
            setState(() {
              type = type == 'log in' ? 'sign up' : 'log in';

              widget.scrollController.animateTo(
                0.0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
            });
          },
          child: _text(
            type == 'log in' ? 'Sign up' : 'Log in',
            color: const Color.fromRGBO(40, 106, 210, 1),
          ),
        ),
      ],
    );
  }

  Widget _text(String text, {Color color = Colors.black}) {
    return Text(
      text,
      style: TextStyle(
        height: 3,
        fontSize: 14,
        color: color,
      ),
    );
  }
}

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _formForgotPassword(),
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

  Widget _formForgotPassword() {
    return Center(
      heightFactor: double.maxFinite,
      widthFactor: double.maxFinite,
      child: Column(
        children: [
          _header(),
          _instruction(),
          ...emailField(),
        ],
      ),
    );
  }

  Widget _header() {
    return const Center(
      child: Text(
        'Reset Password',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _instruction() {
    return const Center(
      child: Text(
        'Please enter your email address to search for your account.',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 16,
        ),
      ),
    );
  }

  List<Widget> emailField() {
    return [
      const Text(
        'Email',
        style: TextStyle(
          height: 3,
          fontSize: 13,
        ),
      ),
      // Login text form with logic check input valid Email
      TextFormField(
        controller: emailController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
        ),
      ),
    ];
  }
}
