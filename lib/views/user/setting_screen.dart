import 'package:flutter/material.dart';
import 'package:let_tutor_app/widgets/body.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainBody(Body(), containFooter: false);
  }
}

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 35),
        //shadow border
        decoration: _shadowBorder(),
        child: Column(
          children: [
            _header(),
            _body(),
            _saveButton(),
          ],
        ));
  }

  Widget _header() {
    return Container(
      padding: const EdgeInsets.all(35),
      // top blue border
      decoration: _topBorder(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset('assets/images/setting.png'),
          )
        ],
      ),
    );
  }

  Widget _body() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
      child: Column(
        children: [
          _inputField('Name'),
          _inputField('Email'),
          _inputField('Phone'),
          _inputField('Address'),
        ],
      ),
    );
  }

  Widget _inputField(String label) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 5),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(5),
            ),
            child: TextField(
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _saveButton() {
    return Container();
  }

  BoxDecoration _shadowBorder() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(5),
      boxShadow: const [
        BoxShadow(
          color: Colors.black12,
          offset: Offset(0, 2),
          blurRadius: 4,
        ),
      ],
    );
  }

  BoxDecoration _topBorder() {
    return const BoxDecoration(
      color: Color(0xFFE5F1FF),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(5),
        topRight: Radius.circular(5),
      ),
    );
  }
}
