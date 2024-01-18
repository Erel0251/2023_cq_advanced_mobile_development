import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  Footer({super.key});

  final List<String> titles = [
    "Privacy Policy ",
    "Terms & Conditions ",
    "Contact ",
    "Guide ",
    "Become a tutor ",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(color: Colors.black54),
        _titles(),
        _details(),
      ],
    );
  }

  Widget _titles() {
    return Wrap(
      spacing: 5,
      alignment: WrapAlignment.start,
      children: [
        for (String title in titles) _headTitle(title),
      ],
    );
  }

  Widget _details() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      color: Colors.black12,
      height: 160,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _richText(
            'Copyright © 2021 Tutoring. All rights reserved.',
            [
              _textSpan('('),
              _textSpan('TC:'),
              _textSpan(' 0317003289)'),
            ],
          ),
          _richText(
            'Headquarters: ',
            [
              _textSpan(
                  '9 Street No. 3, KDC Cityland Park Hills, Ward 10, Go Vap District, Ho Chi Minh City.'),
            ],
          ),
          _richText(
            'Phone: ',
            [
              _textSpan(
                '+84 945 337 337',
                style: const TextStyle(color: Colors.blue),
              ),
              _textSpan('.Email: '),
              _textSpan(
                'hello@lettutor.com',
                style: const TextStyle(color: Colors.blue),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _headTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    );
  }

  Widget _richText(String text, List<TextSpan> children) {
    return RichText(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        children: children,
      ),
    );
  }

  TextSpan _textSpan(String text,
      {TextStyle? style = const TextStyle(
        fontWeight: FontWeight.normal,
        color: Colors.black,
        fontSize: 18,
      )}) {
    return TextSpan(
      text: text,
      style: style,
    );
  }
}
