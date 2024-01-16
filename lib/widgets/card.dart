import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:test_route/views/call_screen.dart';
import 'package:test_route/widgets/avatar.dart';
import 'package:test_route/views/course_info_screen.dart';
import 'package:test_route/widgets/network_image.dart';

class CourseCard extends StatelessWidget {
  const CourseCard(
    this.id, {
    required this.title,
    required this.image,
    required this.description,
    this.level,
    this.totalLesson,
    this.child,
    super.key,
  });

  final String id;
  final String image;
  final String title;
  final String description;
  final String? level;
  final int? totalLesson;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CourseInfoScreen(id)),
        );
      },
      child: Container(
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
          ImageNetwork(image),
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
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
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
      ),
    );
  }
}

class RatingCard extends StatelessWidget {
  const RatingCard({this.rate = 0, super.key});

  final int rate;

  @override
  Widget build(BuildContext context) {
    return DetailCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (rate == 0)
            const Text(
              'Add a Rating',
              style: TextStyle(color: Colors.blue),
            )
          else ...[
            Row(
              children: [const Text('Rating: '), Stars(rate)],
            ),
            const Text(
              'Edit',
              style: TextStyle(color: Colors.blue),
            ),
          ],
          const Text(
            'Report',
            style: TextStyle(color: Colors.blue),
          ),
        ],
      ),
    );
  }
}

class DetailCard extends StatelessWidget {
  const DetailCard({
    required this.child,
    this.margin = const EdgeInsets.symmetric(vertical: 1),
    this.height,
    super.key,
  });

  final EdgeInsetsGeometry margin;
  final double? height;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: margin,
      padding: const EdgeInsets.all(8),
      color: Colors.white,
      child: child,
    );
  }
}

class LessonCard extends StatelessWidget {
  const LessonCard(
      {required this.time,
      required this.date,
      required this.courseTime,
      required this.avatar,
      this.code,
      this.country,
      this.rate = 0,
      this.callable = false,
      this.children,
      super.key});

  final String time;
  final String date;
  final String courseTime;
  final String avatar;
  final String? code;
  final String? country;
  final int rate;
  final bool callable;
  final List<Widget>? children;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      padding: const EdgeInsets.all(16),
      color: const Color.fromRGBO(238, 238, 238, 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            date,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            time,
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 10),
          DetailCard(
            height: 100,
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Avatar(
              'Keegan',
              avatar: 'assets/images/avatar01.jpg',
              edge: 68,
              alignment: CrossAxisAlignment.start,
              detailAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (code != null)
                  Row(
                    children: [
                      Flag.fromString(
                        code!,
                        height: 22,
                        width: 22,
                      ),
                      Text(country!),
                    ],
                  ),
                const Row(
                  children: [
                    Icon(
                      Icons.chat_outlined,
                      size: 14,
                      color: Colors.blue,
                    ),
                    Text(
                      ' Direct Message',
                      style: TextStyle(fontSize: 14, color: Colors.blue),
                    )
                  ],
                )
              ],
            ),
          ),
          if (!callable) ...[
            DetailCard(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Text(
                    'Lesson Time: $courseTime',
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            const DetailCard(
              child: Row(
                children: [
                  Text(
                    'No request for lesson',
                  ),
                ],
              ),
            ),
            const DetailCard(
              child: Row(
                children: [
                  Text(
                    "Tutor haven't reviewed yet",
                  ),
                ],
              ),
            ),
            DetailCard(
              child: RatingCard(
                rate: rate,
              ),
            ),
          ] else ...[
            DetailCard(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        courseTime,
                        style: const TextStyle(fontSize: 20),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.red),
                          color: Colors.white,
                        ),
                        child: const Text(
                          'Cancel',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.red),
                        ),
                      )
                    ],
                  ),
                  Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          color: Colors.white10,
                          border: Border.all(color: Colors.black26)),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            color: Colors.white10,
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Request for lesson'),
                                Text(
                                  'Edit Request',
                                  style: TextStyle(color: Colors.blue),
                                )
                              ],
                            ),
                          ),
                          const Divider(
                            color: Colors.black26,
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            child: const Text(
                              'Currently there are no requests for this class. Please write down any requests for the teacher.',
                              softWrap: true,
                              style: TextStyle(color: Colors.black38),
                            ),
                          ),
                        ],
                      )
                      //
                      )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CallScreen()),
                );
              },
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.blue,
                  child: const Text(
                    'Go to meeting',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ],
      ),
    );
  }
}
