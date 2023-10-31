import 'package:flutter/material.dart';

class CourseCard extends StatelessWidget {
  const CourseCard(this.title,
      {required this.image,
      required this.description,
      this.level,
      this.totalLesson,
      this.child,
      super.key});

  final String image;
  final String title;
  final String description;
  final String? level;
  final int? totalLesson;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 0,
              blurRadius: 0,
              offset: Offset(0, 5), // changes position of shadow
            ),
          ],
          border: Border.all(color: Colors.black12),
          borderRadius: const BorderRadius.all(Radius.circular(12))),
      child: Column(children: [
        Image.asset(image),
        Container(
          height: 160,
          width: double.maxFinite,
          padding: const EdgeInsets.all(24),
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                description,
                softWrap: true,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 12),
              ),
              if (child != null)
                child!
              else
                Text(
                  '$level • $totalLesson Lessons',
                  style: const TextStyle(fontSize: 14),
                )
            ],
          ),
        )
      ]),
    );
  }
}
