import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Header extends StatelessWidget {
  const Header(this.title,
      {required this.descriptions, required this.image, super.key});

  final String image;
  final String title;
  final List<String> descriptions;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(
          image,
          width: 120,
          height: 120,
        ),
        Text(
          title,
          style: const TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, height: 1.5),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 15),
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: const BoxDecoration(
            border: Border(left: BorderSide(color: Colors.black12, width: 3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (String description in descriptions)
                Text(
                  description,
                  softWrap: true,
                  style: const TextStyle(fontSize: 18),
                )
            ],
          ),
        )
      ],
    );
  }
}
