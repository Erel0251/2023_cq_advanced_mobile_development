import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test_route/widgets/button.dart';

class FormInput extends StatelessWidget {
  FormInput({super.key});

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _handleLogin() {
    String username = _usernameController.text;
    String password = _passwordController.text;

    // Add your authentication logic here
    // For simplicity, this example just prints the entered username and password
    print('Username: $username');
    print('Password: $password');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Email',
          style: TextStyle(
            height: 3,
            fontSize: 13,
            color: Color.fromRGBO(164, 176, 190, 1),
          ),
        ),
        TextFormField(
          controller: _usernameController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: "mail@example.com",
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email';
            }
            return null;
          },
        ),
        const Text(
          'Password',
          style: TextStyle(
            height: 3,
            fontSize: 13,
            color: Color.fromRGBO(164, 176, 190, 1),
          ),
        ),
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
        const Text(
          'Forgot password',
          style: TextStyle(
            height: 3,
            fontSize: 16,
            color: Color.fromRGBO(40, 106, 210, 1),
          ),
        ),
        ElevatedButton(
          onPressed: _handleLogin,
          child: const Text(
            'LOG IN',
            style: TextStyle(
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {},
              iconSize: 50.0,
              icon: SvgPicture.asset(
                'assets/images/facebook-logo.3bac8064.svg',
                allowDrawingOutsideViewBox: true,
              ),
            ),
            IconButton(
              onPressed: () {},
              iconSize: 50.0,
              icon: SvgPicture.asset('assets/images/google-logo.5f53496e.svg'),
            ),
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
        )
      ],
    );
  }
}

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Not a member yet? ',
          style: TextStyle(
            height: 3,
            fontSize: 14,
          ),
        ),
        Text(
          'Sign up',
          style: TextStyle(
            height: 3,
            fontSize: 14,
            color: Color.fromRGBO(40, 106, 210, 1),
          ),
        ),
      ],
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  final String title1 = 'Say hello to your English tutors';
  final String title2 =
      'Become fluent faster through one on one video chat lessons tailored to your goals.';

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
        actions: const <Widget>[LanguageButton()],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 10),
        children: [
          Image.asset('assets/images/login.8d01124a.png'),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: Column(
              children: [
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
                FormInput(),
                const Signup(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
