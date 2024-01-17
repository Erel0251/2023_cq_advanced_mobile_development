import 'package:flag/flag.dart';
import 'package:flutter/material.dart';

import 'package:let_tutor_app/controllers/tutor_controller.dart';

import 'package:let_tutor_app/models/tutor/account_info.dart';
import 'package:let_tutor_app/models/tutor/response_tutors.dart';

import 'package:let_tutor_app/utils/format_tags_card.dart';

import 'package:let_tutor_app/views/tutor/tutor_screen.dart';

import 'package:let_tutor_app/widgets/button.dart';
import 'package:let_tutor_app/widgets/body.dart';
import 'package:let_tutor_app/widgets/network_image.dart';
import 'package:let_tutor_app/widgets/pagination.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const MainBody(Body());
  }
}

class Body extends StatefulWidget {
  const Body({super.key});
  final List<String> tags = const [
    'All',
    'English for kids',
    'Business English',
    'Conversational',
    'STARTERS',
    'MOVERS',
    'FLYERS',
    'KET',
    'PET',
    'IELTS',
    'TOEFL',
    'TOEIC',
  ];

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late Future<ResponseTutors> futureTutorsInfo;
  String name = '';
  String tag = 'All';
  String date = '';
  String nationality = '';

  @override
  void initState() {
    super.initState();
    futureTutorsInfo = fetchTutorsInfo();
  }

  String getTagCode(String tag) {
    // transfer tag name to format lower-case and replace space by dash
    return tag.toLowerCase().replaceAll(' ', '-');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Banner(),
          // Search section
          ...searchSection(),
          const Divider(
            color: Colors.black54,
          ),
          // Recommended tutors
          const Text(
            'Recommended Tutors',
            style: TextStyle(
              fontSize: 25,
              height: 2,
              fontWeight: FontWeight.bold,
            ),
          ),
          // filter by search model then sort by liked
          FutureBuilder<ResponseTutors>(
            future: futureTutorsInfo,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: cards(snapshot.data!),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            },
          ),
          const Pagination(5),
        ],
      ),
    );
  }

  List<Card> cards(ResponseTutors data) {
    List<Card> original = data.tutors.row
        .map((e) => Card(
              e,
              // check data.favoriteTutors if its secondId contains e.userId
              isLiked: data.favoriteTutors!
                  .map((e) => e.secondId)
                  .contains(e.userId),
            ))
        .toList();

    original = original
        .where((card) =>
            card.info.name!.toLowerCase().contains(name.toLowerCase()) &&
            (card.info.specialties!.contains(getTagCode(tag)) || tag == 'All'))
        .toList();
    return original..sort((a, b) => a.isLiked ? 0 : 1);
  }

  List<Widget> searchSection() {
    return [
      const Text(
        'Find a tutor',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 20),
      Wrap(
        spacing: 10,
        children: [
          _filterName(),
          _filterNationality(),
        ],
      ),
      const Text(
        'Select available tutoring time:',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          height: 2,
        ),
      ),
      Wrap(
        spacing: 10,
        children: [
          _filterFromDate(),
          _filterToDate(),
        ],
      ),
      tags(),
      ResetFilterButton('Reset Filter', onPressed: () {
        setState(() {
          name = '';
          tag = 'All';
          date = '';
          nationality = '';
        });
      }),
    ];
  }

  Widget _filterName() {
    return SizedBox(
      width: 165,
      child: TextField(
        onSubmitted: (value) {
          setState(() {
            name = value;
          });
        },
        controller: TextEditingController(text: name),
        style: const TextStyle(fontSize: 14, color: Colors.black),
        decoration: const InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(50))),
          hintText: 'Search by name',
          isDense: true, // Added this
          contentPadding: EdgeInsets.all(8),
        ),
      ),
    );
  }

  Widget _filterNationality() {
    return SizedBox(
      width: 165,
      child: TextField(
        onSubmitted: (value) {
          setState(() {
            nationality = value;
          });
        },
        controller: TextEditingController(text: nationality),
        style: const TextStyle(fontSize: 14, color: Colors.black),
        decoration: const InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(50))),
          hintText: 'Select tutor nationality',
          isDense: true, // Added this
          contentPadding: EdgeInsets.all(8),
        ),
      ),
    );
  }

  Widget _filterFromDate() {
    return const SizedBox(
      width: 140,
      child: TextField(
        style: TextStyle(fontSize: 14, color: Colors.black),
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(50))),
          hintText: 'Select a day',
          isDense: true, // Added this
          contentPadding: EdgeInsets.symmetric(horizontal: 8),
          suffixIcon: Icon(Icons.calendar_month),
        ),
      ),
    );
  }

  Widget _filterToDate() {
    return const SizedBox(
      width: 200,
      child: TextField(
        style: TextStyle(fontSize: 14, color: Colors.black),
        decoration: InputDecoration(
          border: OutlineInputBorder(
              gapPadding: 0,
              borderRadius: BorderRadius.all(Radius.circular(50))),
          hintText: 'Start time End time',
          isDense: true, // Added this
          contentPadding: EdgeInsets.all(8),
          suffixIcon: Icon(Icons.schedule),
        ),
      ),
    );
  }

  Widget tags() {
    return Wrap(
      children: widget.tags
          .map((tag) => GestureDetector(
                onTap: () {
                  setState(() {
                    this.tag = tag;
                  });
                },
                child: TagFilter(tag, isChecked: this.tag == tag),
              ))
          .toList(),
    );
  }
}

class Banner extends StatelessWidget {
  const Banner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(5)),
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 12, 61, 223),
            Color.fromARGB(255, 5, 23, 157)
          ],
        ),
      ),
      height: 230,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          textTitle(),
          textTimeLesson(),
          buttonEnterLessonRoom(),
          textTotalLessonTime(),
        ],
      ),
    );
  }

  // Widget text title
  Widget textTitle() {
    return const Text(
      'Upcoming lesson',
      style: TextStyle(
        fontSize: 30,
        color: Colors.white,
      ),
    );
  }

  // Widget text time lesson
  Widget textTimeLesson() {
    return Wrap(
      children: [
        RichText(
          text: const TextSpan(
            text: 'Sun, 29 Oct 23 01:30 - 01:55 ',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
            children: [
              TextSpan(
                text: '(starts in 01:40:04)',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.yellow,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Widget button enter lesson room
  Widget buttonEnterLessonRoom() {
    return Container(
      width: 180,
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            Icons.play_arrow_sharp,
            color: Color.fromARGB(255, 12, 61, 223),
          ),
          Text(
            'Enter lesson room',
            style: TextStyle(
              height: 2,
              color: Color.fromARGB(255, 12, 61, 223),
            ),
          ),
        ],
      ),
    );
  }

  // Widget text total lesson time
  Widget textTotalLessonTime() {
    return const Text(
      'Total lesson time is 512 hours 55 minutes',
      style: TextStyle(
        fontSize: 16,
        height: 2,
        color: Colors.white,
      ),
    );
  }
}

class Card extends StatelessWidget {
  const Card(
    this.info, {
    this.isLiked = false,
    super.key,
  });

  final TutorInfo info;
  final bool isLiked;

  String getName() {
    return info.name!.split(' ').map((e) => e[0]).join();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  TutorScreen(info.userId!, feedbacks: info.feedbacks)),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
            ),
          ],
        ),
        constraints: const BoxConstraints(
          minHeight: 300,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      margin: const EdgeInsets.only(right: 20),
                      clipBehavior: Clip.hardEdge,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(0, 133, 240, 1),
                        shape: BoxShape.circle,
                      ),
                      child: (info.avatar != null)
                          ? ImageNetwork(info.avatar)
                          : Center(
                              child: Text(
                                getName(),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 40),
                              ),
                            ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          info.name!,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        (info.language != null)
                            ? Row(
                                children: [
                                  Flag.fromString(
                                    info.country!,
                                    height: 22,
                                    width: 22,
                                  ),
                                  Text(info.language!),
                                ],
                              )
                            : const Icon(Icons.image_not_supported),
                        (info.rating != null)
                            ? Row(
                                children: [
                                  for (int i = 1;
                                      i <= info.rating!.toInt();
                                      i++)
                                    const Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                      size: 16,
                                    ),
                                ],
                              )
                            : const Text(
                                'No reviews yet',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                      ],
                    ),
                  ],
                ),
                (isLiked)
                    ? const Icon(
                        Icons.favorite,
                        color: Colors.pink,
                        size: 32,
                      )
                    : const Icon(
                        Icons.favorite_border,
                        color: Color.fromRGBO(0, 133, 240, 1),
                        size: 32,
                      ),
              ],
            ),
            Wrap(
              children: [
                for (String tag in formatTagsCard(info.specialties!))
                  TagFilter(tag, isChecked: true),
              ],
            ),
            Text(
              info.bio!,
              softWrap: true,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 100,
                  margin: const EdgeInsets.all(5),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.blue,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(16))),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.fact_check_rounded,
                        size: 18,
                        color: Colors.blue,
                      ),
                      Text(
                        ' Book',
                        style: TextStyle(fontSize: 14, color: Colors.blue),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
