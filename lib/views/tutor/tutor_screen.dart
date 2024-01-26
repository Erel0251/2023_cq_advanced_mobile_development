import 'dart:math';

import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:let_tutor_app/controllers/schedule_controller.dart';
import 'package:let_tutor_app/models/schedule/schedule.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:video_player/video_player.dart';

import 'package:let_tutor_app/controllers/tutor_controller.dart';

import 'package:let_tutor_app/models/meeting.dart';
import 'package:let_tutor_app/models/tutor/account_info.dart';
import 'package:let_tutor_app/models/tutor/feedback.dart';
import 'package:let_tutor_app/models/course/course.dart';

import 'package:let_tutor_app/views/courses/course_info_screen.dart';

import 'package:let_tutor_app/utils/get_name.dart';
import 'package:let_tutor_app/utils/format_date_range.dart';
import 'package:let_tutor_app/utils/format_tags_card.dart';

import 'package:let_tutor_app/widgets/button.dart';
import 'package:let_tutor_app/widgets/body.dart';
import 'package:let_tutor_app/widgets/pagination.dart';
import 'package:let_tutor_app/widgets/network_image.dart';

// TODO: calendar, booking form, favorite & report button
class TutorScreen extends StatelessWidget {
  const TutorScreen(this.tutorId, {this.feedbacks, super.key});
  final String tutorId;
  final List<dynamic>? feedbacks;

  @override
  Widget build(BuildContext context) {
    return MainBody(Body(tutorId, feedbacks: feedbacks));
  }
}

class Body extends StatefulWidget {
  const Body(this.tutorId, {this.feedbacks, super.key});
  final String tutorId;
  final List<dynamic>? feedbacks;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late Future<TutorInfo> futureTutorsInfo;
  late Future<List<Schedule>> futureSchedule;

  @override
  void initState() {
    super.initState();
    futureTutorsInfo = fetchTutorById(widget.tutorId);
    futureSchedule = getScheduleByTutorId(widget.tutorId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([futureTutorsInfo, futureSchedule]),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          TutorInfo tutor = snapshot.data![0] as TutorInfo;
          List<Schedule> schedules = snapshot.data![1] as List<Schedule>;
          return _hasData(tutor, schedules);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }

  Widget _hasData(TutorInfo tutor, List<Schedule> schedules) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 35),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Detail About Tutor
          Detail(tutor),
          VideoPlayerScreen(tutor.video ?? ''),
          // Detail Description
          ..._categories(tutor),
          ..._templateReview(),
          // weekly schedule
          _calendar(schedules),
        ],
      ),
    );
  }

  SfCalendar _calendar(List<Schedule> schedules) {
    return SfCalendar(
      view: CalendarView.week,
      firstDayOfWeek: DateTime.now().weekday,
      showNavigationArrow: true,
      showDatePickerButton: true,
      showCurrentTimeIndicator: true,
      timeSlotViewSettings: const TimeSlotViewSettings(
        timeTextStyle: TextStyle(
          fontSize: 10,
        ),
        timeIntervalHeight: 30,
        timeIntervalWidth: 250,
        timeInterval: Duration(minutes: 30),
        timeFormat: 'kk:mm',
      ),
      dataSource: MeetingDataSource(_getDataSource(schedules)),
      onTap: calendarTapped,
    );
  }

  List<Meeting> _getDataSource(List<Schedule> schedules) {
    final List<Meeting> meetings = schedules.map((e) {
      String eventName = (e.isBooked!) ? 'Booked' : 'Book';

      String userId = dotenv.env['id'] ?? '';

      if (eventName == 'Booked') {
        if (e.scheduleDetails != null &&
            e.scheduleDetails!.any((lesson) =>
                lesson.bookingInfos != null &&
                lesson.bookingInfos!
                    .any((student) => student.userId == userId))) {
          eventName = 'Reserved';
        }
      }

      Color background;
      switch (eventName) {
        case 'Booked':
          background = const Color(0xFF0F8644);
          break;
        case 'Reserved':
          background = Colors.grey;
          break;
        default:
          background = Colors.blue;
      }

      DateTime startTime =
          DateTime.fromMillisecondsSinceEpoch(e.startTimeStamp);
      DateTime endTime = DateTime.fromMillisecondsSinceEpoch(e.endTimeStamp);

      return Meeting(eventName, startTime, endTime, background, false);
    }).toList();
    return meetings;
  }

  void calendarTapped(CalendarTapDetails calendarTapDetails) {
    if (calendarTapDetails.targetElement == CalendarElement.appointment ||
        calendarTapDetails.targetElement == CalendarElement.agenda) {
      final Meeting appointmentDetails = calendarTapDetails.appointments![0];
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(appointmentDetails.eventName),
          content: _form(appointmentDetails),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'Book'),
              child: const Text('Book'),
            ),
          ],
        ),
      );
    }
  }

  Form _form(Meeting appointmentDetails) {
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          // horizontal line
          const Divider(thickness: 0.7),
          _time(
            formatTimeRange(
              appointmentDetails.from,
              appointmentDetails.to,
            ),
          ),
          _price(),

          const Divider(thickness: 0.7),
          _notes(),
        ],
      ),
    );
  }

  Widget _time(String formatTimeRange) {
    return Table(
      border: TableBorder.all(
        color: Colors.black12,
        width: 0.7,
      ),
      children: [
        TableRow(
          children: [_titleSection('Booking time')],
        ),
        TableRow(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: const Color.fromARGB(255, 223, 202, 243),
              ),
              child: Center(
                child: Text(
                  formatTimeRange,
                  style: const TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _price() {
    return Table(
      border: TableBorder.all(
        color: Colors.black12,
        width: 0.7,
      ),
      children: [
        TableRow(
          children: [
            _titleSection('Balance'),
            const Text('You have n lessons left'),
          ],
        ),
        TableRow(
          children: [
            _titleSection('Price'),
            const Text('1 lesson'),
          ],
        ),
      ],
    );
  }

  Widget _notes() {
    return Table(
      border: TableBorder.all(
        color: Colors.black12,
        width: 0.7,
      ),
      children: [
        TableRow(
          children: [
            _titleSection('Notes'),
          ],
        ),
        TableRow(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              child: _textFormField(),
            ),
          ],
        ),
      ],
    );
  }

  Widget _titleSection(String title) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Color.fromARGB(10, 0, 0, 0),
      ),
      child: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  TextFormField _textFormField() {
    return TextFormField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
      ),
      maxLines: 4,
    );
  }

  List<Widget> _categories(TutorInfo tutor) {
    return [
      Part(
        'Education',
        description: tutor.education,
      ),
      Part(
        'Languages',
        tags: tutor.languages!.split(', '),
      ),
      Part(
        'Specialties',
        tags: formatTagsCard(tutor.specialties!),
      ),
      Part(
        'Suggested courses',
        courses: tutor.user!.courses,
      ),
      Part(
        'Interests',
        description: tutor.interests,
      ),
      Part(
        'Teaching experience',
        description: tutor.experience,
      ),
    ];
  }

  List<Widget> _templateReview() {
    return [
      const Text(
        'Other review',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 17,
          height: 2.5,
        ),
      ),
      ...widget.feedbacks!
          .map(
            (e) => Review(e),
          )
          .take(20),
      const Pagination(1),
    ];
  }
}

class Detail extends StatelessWidget {
  const Detail(this.tutor, {super.key});

  final TutorInfo tutor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _infoSection(),
        _bioTutor(),
        _interactionButtons(),
      ],
    );
  }

  Widget _infoSection() {
    return Row(
      children: [
        // Avatar of tutor
        Container(
          width: 110,
          height: 110,
          margin: const EdgeInsets.only(right: 20),
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: (tutor.user!.avatar != null)
              ? ImageNetwork(tutor.user!.avatar)
              : Center(
                  child: Text(
                    getName(tutor.user!.name!),
                    style: const TextStyle(color: Colors.white, fontSize: 40),
                  ),
                ),
        ),
        // Information of tutor
        SizedBox(
          height: 110,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Tutor name
              Text(
                tutor.user!.name!,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Review score
              (tutor.rating != null)
                  ? Row(
                      children: [
                        for (int i = 1; i <= tutor.rating!.toInt(); i++)
                          const Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 16,
                          ),
                        Text(' (${tutor.totalFeedbacks!})'),
                      ],
                    )
                  : const Text(
                      'No reviews yet',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
              // Country Flag
              Row(
                children: [
                  Flag.fromString(
                    tutor.user!.country!,
                    height: 22,
                    width: 22,
                  ),
                  Text(tutor.user!.language!),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _bioTutor() {
    return Text(
      tutor.bio!,
      softWrap: true,
      style: const TextStyle(height: 1.5),
    );
  }

  Widget _interactionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        FavoriteButton(tutor.user!.id!),
        ReportButton(tutor.user!.id!, tutor.user!.name!),
      ],
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen(this.url, {super.key});
  final String url;

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(
        widget.url,
      ),
    );

    //_controller = VideoPlayerController.asset('assets/videos/video-tutor.mp4');

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(true);
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // build video screen with center play button show when video is not playing,
    // and video controller bar show when video is playing
    return FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return _video();
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget _video() {
    return AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      // Use the VideoPlayer widget to display the video.
      child: GestureDetector(
        onTap: () {
          setState(() {
            // If the video is playing, pause it.
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              // If the video is paused, play it.
              _controller.play();
            }
          });
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            VideoPlayer(_controller),
            _buttonPlay(),
          ],
        ),
      ),
    );
  }

  Widget _buttonPlay() {
    return _controller.value.isPlaying
        ? Container()
        : Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(50),
            ),
            child: const Icon(
              Icons.play_arrow,
              color: Colors.white,
              size: 40,
            ),
          );
  }

  Widget _tabbar() {
    return Positioned(
      bottom: 0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 40,
        color: Colors.black.withOpacity(0.5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  _controller.seekTo(
                    const Duration(seconds: 0),
                  );
                });
              },
              icon: const Icon(
                Icons.replay_10,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  _controller.seekTo(
                    _controller.value.position - const Duration(seconds: 10),
                  );
                });
              },
              icon: const Icon(
                Icons.replay_10,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  if (_controller.value.isPlaying) {
                    _controller.pause();
                  } else {
                    _controller.play();
                  }
                });
              },
              icon: Icon(
                _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Part extends StatelessWidget {
  const Part(
    this.title, {
    this.description,
    this.tags,
    this.contents,
    this.courses,
    super.key,
  });

  final String title;
  final String? description;
  final List<String>? tags;
  final List<String>? contents;
  final List<dynamic>? courses;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
            height: 2.5,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Column(
            children: [
              if (description != null)
                Text(
                  description!,
                  style: const TextStyle(
                      color: Colors.black54, overflow: TextOverflow.visible),
                ),
              if (tags != null)
                Wrap(
                  children: [
                    for (String tag in tags!) TagFilter(tag, isChecked: true),
                  ],
                ),
              if (contents != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (String content in contents!)
                      RichText(
                        text: TextSpan(
                          text: '$content:  ',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          children: const [
                            TextSpan(
                              text: 'link',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              if (courses != null)
                Column(
                  children: (courses!.isNotEmpty)
                      ? courses!.map((e) => _courseLink(context, e)).toList()
                      : [const Text('No courses')],
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _courseLink(BuildContext context, Course course) {
    return Row(
      children: [
        Text(course.name),
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CourseInfoScreen(course.id),
            ),
          ),
          child: const Text(
            'Link',
            style: TextStyle(
              fontSize: 14,
              color: Colors.blue,
            ),
          ),
        ),
      ],
    );
  }
}

class Review extends StatelessWidget {
  const Review(this.feedback, {super.key});

  final FeedbackTutor feedback;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            margin: const EdgeInsets.only(right: 20),
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: (feedback.firstInfo!.avatar != null)
                ? ImageNetwork(feedback.firstInfo!.avatar)
                : Center(
                    child: Text(
                      getName(feedback.firstInfo!.name!),
                      style: const TextStyle(color: Colors.white, fontSize: 40),
                    ),
                  ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: feedback.firstInfo!.name!,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color.fromRGBO(0, 0, 0, 0.45),
                  ),
                  children: [
                    TextSpan(
                      text: feedback.updatedAt!,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color.fromRGBO(204, 204, 204, 1),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  for (int i = 1; i <= 5; i++)
                    Icon(
                      Icons.star,
                      color: i <= feedback.rating!.toInt()
                          ? Colors.yellow
                          : Colors.grey,
                      size: 16,
                    ),
                ],
              ),
              (feedback.content == null)
                  ? const SizedBox(
                      height: 5,
                    )
                  : Text(
                      feedback.content!,
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                    ),
            ],
          )
        ],
      ),
    );
  }
}
