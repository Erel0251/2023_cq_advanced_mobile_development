import 'package:flutter/material.dart';
import 'package:let_tutor_app/widgets/network_image.dart';

class Avatar extends StatelessWidget {
  const Avatar(
    this.name, {
    required this.avatar,
    this.time,
    this.alignment = CrossAxisAlignment.start,
    this.detailAlignment = MainAxisAlignment.spaceEvenly,
    this.edge = 32,
    this.children,
    super.key,
  });

  final String avatar;
  final String name;
  final String? time;
  final double edge;
  final CrossAxisAlignment alignment;
  final MainAxisAlignment detailAlignment;
  final List<Widget>? children;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: edge,
            height: edge,
            margin: const EdgeInsets.only(right: 20),
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: ImageNetwork(avatar),
          ),
          Column(
            crossAxisAlignment: alignment,
            mainAxisAlignment: detailAlignment,
            children: [
              RichText(
                text: TextSpan(
                  text: name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  children: [
                    if (time != null)
                      TextSpan(
                        text: time!,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color.fromRGBO(204, 204, 204, 1),
                        ),
                      ),
                  ],
                ),
              ),
              if (children != null)
                for (Widget child in children!) ...[
                  child,
                ],
            ],
          )
        ],
      ),
    );
  }
}

class Stars extends StatelessWidget {
  const Stars(this.point, {this.total = 5, this.starSize = 16, super.key});

  final int point;
  final int total;
  final double starSize;

  Color getStarColor(int i) {
    if (i > point) {
      return Colors.grey;
    } else {
      return Colors.yellow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 1; i <= total; i++)
          Icon(
            Icons.star,
            color: getStarColor(i),
            size: starSize,
          ),
      ],
    );
  }
}
