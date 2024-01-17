import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:video_player/video_player.dart';

import 'package:let_tutor_app/controllers/tutor_action.dart';

import 'package:let_tutor_app/models/meeting.dart';
import 'package:let_tutor_app/models/tutor/account_info.dart';
import 'package:let_tutor_app/models/tutor/feedback.dart';
import 'package:let_tutor_app/models/tutor/course.dart';

import 'package:let_tutor_app/views/course_info_screen.dart';

import 'package:let_tutor_app/utils/get_name.dart';
import 'package:let_tutor_app/utils/format_date_range.dart';
import 'package:let_tutor_app/utils/format_tags_card.dart';

import 'package:let_tutor_app/widgets/button.dart';
import 'package:let_tutor_app/widgets/body.dart';
import 'package:let_tutor_app/widgets/pagination.dart';
import 'package:let_tutor_app/widgets/network_image.dart';

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
  late Future<AccountInfo> futureTutorsInfo;

  @override
  void initState() {
    super.initState();
    futureTutorsInfo = fetchTutorById(widget.tutorId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureTutorsInfo,
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          return _hasData(snapshot.data);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }

  Widget _hasData(tutor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 35),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Detail About Tutor
          Detail(tutor),
          VideoPlayerScreen(tutor.video),
          // Detail Description
          ..._categories(tutor),
          ..._templateReview(widget.feedbacks!),
          // weekly schedule
          _calendar(),
        ],
      ),
    );
  }

  SfCalendar _calendar() {
    return SfCalendar(
      view: CalendarView.week,
      firstDayOfWeek: 1,
      showNavigationArrow: true,
      showDatePickerButton: true,
      showCurrentTimeIndicator: true,
      timeSlotViewSettings: const TimeSlotViewSettings(
        startHour: 8,
        endHour: 24,
        timeIntervalHeight: 50,
        timeIntervalWidth: 100,
        timeInterval: Duration(minutes: 60),
        timeFormat: 'hh:mm a',
      ),
      dataSource: MeetingDataSource(_getDataSource()),
      onTap: calendarTapped,
    );
  }

  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    final DateTime startTime =
        DateTime(today.year, today.month, today.day, 9, 0, 0);
    final DateTime endTime = startTime.add(const Duration(hours: 1));
    meetings.add(
        Meeting('Book', startTime, endTime, const Color(0xFF0F8644), false));
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
            Text('You have n lessons left'),
          ],
        ),
        TableRow(
          children: [
            _titleSection('Price'),
            Text('1 lesson'),
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
}

class Detail extends StatelessWidget {
  const Detail(this.tutor, {super.key});

  final AccountInfo tutor;

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
        const FavoriteButton(),
        ReportButton(tutor.user!.name!),
      ],
    );
  }
}

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({super.key});

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isLiked = !isLiked;
        });
      },
      child: Column(
        children: [
          Icon(
            isLiked ? Icons.favorite : Icons.favorite_outline_rounded,
            color: isLiked ? Colors.redAccent : Colors.blue,
          ),
          Text(
            'Favorite',
            style: TextStyle(color: isLiked ? Colors.redAccent : Colors.blue),
          ),
        ],
      ),
    );
  }
}

class ReportButton extends StatelessWidget {
  const ReportButton(this.nameTutor, {super.key});
  final String nameTutor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: const Column(
        children: [
          Icon(
            Icons.info_outline_rounded,
            color: Colors.blue,
          ),
          Text(
            'Report',
            style: TextStyle(color: Colors.blue),
          ),
        ],
      ),
      // popup report form dialog
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: _titleDialog(),
            content: _formReport(),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, 'Submit'),
                child: const Text('Submit'),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _titleDialog() {
    return Text(
      'Report $nameTutor',
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _formReport() {
    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // horizontal line
          const Divider(thickness: 1),
          // little header
          const Text(
            "Help us understand what's happening",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          // Checkbox button and description about reason report
          const CheckBoxReasonReport('This tutor is annoying me'),
          const CheckBoxReasonReport(
              'This profile is pretending be someone or is fake'),
          const CheckBoxReasonReport('Inappropriate profile photo'),
          // Textfield for more detail
          _textFormField(),
        ],
      ),
    );
  }

  TextFormField _textFormField() {
    return TextFormField(
      decoration: const InputDecoration(
        hintText: 'Please let us know details about your problem',
        border: OutlineInputBorder(),
      ),
      maxLines: 3,
    );
  }
}

class CheckBoxReasonReport extends StatefulWidget {
  const CheckBoxReasonReport(this.reason, {super.key});
  final String reason;

  @override
  State<CheckBoxReasonReport> createState() => _CheckBoxReasonReportState();
}

class _CheckBoxReasonReportState extends State<CheckBoxReasonReport> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: isChecked,
          onChanged: (value) {
            setState(() {
              isChecked = value!;
            });
          },
        ),
        // wrap text if it's too long
        Expanded(
          child: Text(
            widget.reason,
            overflow: TextOverflow.visible,
          ),
        ),
      ],
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen(this.url, {super.key});
  final String? url;

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
        widget.url!,
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
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // If the VideoPlayerController has finished initialization, use
          // the data it provides to limit the aspect ratio of the video.
          return AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            // Use the VideoPlayer widget to display the video.
            child: VideoPlayer(_controller),
          );
        } else {
          // If the VideoPlayerController is still initializing, show a
          // loading spinner.
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
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
  final List<Course>? courses;

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

List<Widget> _categories(AccountInfo tutor) {
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
      courses: (tutor.courses as List<Course>?),
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

List<Widget> _templateReview(List<dynamic> reviews) {
  return [
    const Text(
      'Other review',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 17,
        height: 2.5,
      ),
    ),
    ...reviews.map(
      (e) => Review(e),
    ),
    const Pagination(1),
  ];
}
