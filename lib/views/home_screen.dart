import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:let_tutor_app/models/tutor/response_search.dart';
import 'package:let_tutor_app/widgets/card.dart';
import 'package:provider/provider.dart';
import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';

import 'package:let_tutor_app/controllers/schedule_controller.dart';

import 'package:let_tutor_app/models/schedule/booking_info.dart';
import 'package:let_tutor_app/models/schedule/response_booked.dart';

import 'package:let_tutor_app/providers/tutor_provider.dart';

import 'package:let_tutor_app/widgets/button.dart';
import 'package:let_tutor_app/widgets/body.dart';
import 'package:let_tutor_app/widgets/pagination.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainBody(
      ChangeNotifierProvider(
        create: (context) => TutorProvider(),
        child: const Body(),
      ),
    );
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
  late Future<ResponseSearchTutor> futureTutorsInfo;
  late Future<ListBooked> futureBookedClass;
  late Future<String> futureTotalLesson;

  String name = '';
  String tag = 'All';
  String date = '';
  String nationality = '';
  int totalLesson = 0;
  BookingInfo? upcomingLesson;

  @override
  void initState() {
    super.initState();
    futureBookedClass = getFutureBookedClass(perPage: 1);
    futureTotalLesson = getTotalTimeBooked();
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
          FutureBuilder(
              future: Future.wait([futureBookedClass, futureTotalLesson]),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  ListBooked bookedClass = snapshot.data![0] as ListBooked;
                  String totalLesson = snapshot.data![1] as String;

                  return Banner(bookedClass.rows, totalLesson: totalLesson);
                } else if (snapshot.hasError) {
                  return const Banner(null);
                }
                return const Banner(null);
              }),
          // Search section
          ...searchSection(context),
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
          FutureBuilder<ResponseSearchTutor>(
            future: context.watch<TutorProvider>().filterTutors(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    ...cards(snapshot.data!),
                    Pagination(
                      snapshot.data!.count,
                      current: context.read<TutorProvider>().page,
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            },
          ),
        ],
      ),
    );
  }

  List<Widget> cards(ResponseSearchTutor data) {
    List<TutorCard> original = data.rows.map((e) {
      return TutorCard(e);
    }).toList();

    return original.isNotEmpty
        ? original
        : [
            const SizedBox(
              width: double.maxFinite,
              height: 300,
              child: Center(
                  child:
                      Text("Sorry we can't find any tutor with this keywords")),
            )
          ];
  }

  List<Widget> searchSection(BuildContext context) {
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
          _filterName(context),
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
          _filterDate(context),
          _filterRange(),
        ],
      ),
      tags(context),
      ResetFilterButton('Reset Filter', onPressed: () {
        setState(() {
          name = '';
          tag = 'All';
          date = '';
          nationality = '';
        });
        context.read<TutorProvider>().clear();
      }),
    ];
  }

  Widget _filterName(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return SizedBox(
      width: double.maxFinite,
      child: TextField(
        onEditingComplete: () => {
          name = controller.text,
          context.read<TutorProvider>().setSearch(name),
        },
        controller: controller,
        style: const TextStyle(fontSize: 14, color: Colors.black),
        decoration: const InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(50))),
          hintText: 'Search by name',
          isDense: true, // Added this
          contentPadding: EdgeInsets.all(12),
        ),
      ),
    );
  }

  Widget _filterNationality() {
    return const MultiplePrompted();
  }

  Widget _filterDate(BuildContext context) {
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

  Widget _filterRange() {
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

  Widget tags(BuildContext context) {
    return Wrap(
      children: widget.tags
          .map((tag) => GestureDetector(
                onTap: () {
                  setState(() {
                    this.tag = tag;
                  });
                  context.read<TutorProvider>().setSpecialties(tag.contains(' ')
                      ? tag.replaceAll(' ', '-').toLowerCase()
                      : tag);
                },
                child: TagFilter(tag, isChecked: this.tag == tag),
              ))
          .toList(),
    );
  }
}

class Banner extends StatefulWidget {
  const Banner(this.bookedClass, {this.totalLesson = '', super.key});

  final List<BookingInfo>? bookedClass;
  final String totalLesson;

  @override
  State<Banner> createState() => _BannerState();
}

class _BannerState extends State<Banner> {
  late Timer _timer;
  int now = DateTime.now().millisecondsSinceEpoch;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        now = DateTime.now().millisecondsSinceEpoch;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String getLessonTime(int startedTime, int endTime) {
    DateTime started = DateTime.fromMillisecondsSinceEpoch(startedTime);
    DateTime end = DateTime.fromMillisecondsSinceEpoch(endTime);
    int endHour = end.hour;
    int endMinute = end.minute;
    String startTime = DateFormat("EEE, dd MMM yy kk:mm").format(started);
    return '$startTime - $endHour:$endMinute';
  }

  String getTimeLeft(int startedTime) {
    int timeLeft = startedTime - now;
    String time = DateFormat("kk:mm:ss")
        .format(DateTime.fromMillisecondsSinceEpoch(timeLeft, isUtc: true));
    return time;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 230,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: decoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ..._buildBanner(),
          textTotalLessonTime(),
        ],
      ),
    );
  }

  Decoration decoration() {
    return const BoxDecoration(
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(5)),
      gradient: LinearGradient(
        colors: [
          Color.fromARGB(255, 12, 61, 223),
          Color.fromARGB(255, 5, 23, 157)
        ],
      ),
    );
  }

  List<Widget> _buildBanner() {
    if (widget.bookedClass == null || widget.bookedClass!.isEmpty) {
      return [textTitle('No upcoming lesson')];
    } else {
      return [
        textTitle('Upcoming lesson'),
        textTimeLesson(widget.bookedClass!.first),
        textTimeLeft(widget.bookedClass!.first),
        buttonEnterLessonRoom(
            widget.bookedClass!.first.studentMeetingLink ?? ''),
      ];
    }
  }

  // Widget text title
  Widget textTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 30,
        color: Colors.white,
      ),
    );
  }

  Widget textTimeLeft(BookingInfo booked) {
    return Text(
      '(starts in ${getTimeLeft(booked.scheduleDetailInfo!.startPeriodTimestamp)})',
      style: const TextStyle(
        fontSize: 16,
        color: Colors.yellow,
      ),
    );
  }

  // Widget text time lesson
  Widget textTimeLesson(BookingInfo booked) {
    return Text(
      getLessonTime(
        booked.scheduleDetailInfo!.startPeriodTimestamp,
        booked.scheduleDetailInfo!.endPeriodTimestamp,
      ),
      style: const TextStyle(
        fontSize: 20,
        color: Colors.white,
      ),
    );
  }

  // Widget button enter lesson room
  Widget buttonEnterLessonRoom(String path) {
    return GestureDetector(
      onTap: () {
        //String baseUrl = 'https://sandbox.app.lettutor.com';

        var options = JitsiMeetConferenceOptions(
          //serverURL: baseUrl + path,
          room: 'Let tutor meeting',
          configOverrides: {
            "startWithAudioMuted": false,
            "startWithVideoMuted": false,
            "subject": "Lipitori",
          },
          featureFlags: {
            "unsaferoomwarning.enabled": false,
            "ios.screensharing.enabled": true
          },
          userInfo: JitsiMeetUserInfo(
              displayName: "Gabi",
              email: "gabi.borlea.1@gmail.com",
              avatar:
                  "https://avatars.githubusercontent.com/u/57035818?s=400&u=02572f10fe61bca6fc20426548f3920d53f79693&v=4"),
        );
        JitsiMeet().join(options);
      },
      child: Container(
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
      ),
    );
  }

  // Widget text total lesson time
  Widget textTotalLessonTime() {
    return Text(
      widget.totalLesson.isNotEmpty
          ? widget.totalLesson
          : "Welcome to Let's Tutor",
      style: const TextStyle(
        fontSize: 16,
        height: 2,
        color: Colors.white,
      ),
    );
  }
}
