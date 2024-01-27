import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:let_tutor_app/controllers/schedule_controller.dart';
import 'package:let_tutor_app/controllers/tutor_controller.dart';
import 'package:let_tutor_app/models/tutor/account_info.dart';
import 'package:let_tutor_app/utils/format_tags_card.dart';
import 'package:let_tutor_app/views/lessons/call_screen.dart';
import 'package:let_tutor_app/views/tutor/tutor_screen.dart';
import 'package:let_tutor_app/widgets/avatar.dart';
import 'package:let_tutor_app/views/courses/course_info_screen.dart';
import 'package:let_tutor_app/widgets/button.dart';
import 'package:let_tutor_app/widgets/network_image.dart';

class CourseCard extends StatelessWidget {
  const CourseCard(
    this.id, {
    required this.title,
    required this.image,
    required this.description,
    this.level,
    this.totalLesson,
    this.child,
    this.filelUrl,
    super.key,
  });

  final String id;
  final String image;
  final String title;
  final String description;
  final String? level;
  final int? totalLesson;
  final Widget? child;
  final String? filelUrl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (filelUrl == null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CourseInfoScreen(id)),
          );
        }
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
  const RatingCard({this.rate, super.key});

  final int? rate;

  @override
  Widget build(BuildContext context) {
    return DetailCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (rate == null)
            const Text(
              'Add a Rating',
              style: TextStyle(color: Colors.blue),
            )
          else ...[
            Row(
              children: [const Text('Rating: '), Stars(rate!)],
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
      width: double.maxFinite,
      height: height,
      margin: margin,
      padding: const EdgeInsets.all(8),
      color: Colors.white,
      alignment: Alignment.centerLeft,
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
      required this.nameTutor,
      this.id = '',
      this.cancelable = false,
      this.code,
      this.country,
      this.rates = const [],
      this.callable = false,
      this.children,
      this.studentRequest,
      this.tutorReview,
      super.key});

  final String id;
  final String time;
  final String date;
  final String courseTime;
  final bool cancelable;
  final String nameTutor;
  final String avatar;
  final String? code;
  final String? country;
  final List<int> rates;
  final bool callable;
  final List<Widget>? children;
  final String? studentRequest;
  final String? tutorReview;
  final String defaultRequest =
      'Currently there are no requests for this class. Please write down any requests for the teacher.';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      padding: const EdgeInsets.all(16),
      color: const Color.fromRGBO(238, 238, 238, 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _date(),
          _time(),
          const SizedBox(height: 10),
          DetailCard(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Avatar(
              nameTutor,
              avatar: avatar,
              edge: 68,
              children: [
                if (code != null) _flag(),
                _message(),
              ],
            ),
          ),
          if (callable) ..._commingClass(context) else ..._historyClass(),
        ],
      ),
    );
  }

  Widget _date() {
    return Text(
      date,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _time() {
    return Text(
      time,
      style: const TextStyle(fontSize: 14),
    );
  }

  Widget _flag() {
    return Row(
      children: [
        Flag.fromString(
          code!,
          height: 22,
          width: 22,
        ),
        Text(' $country'),
      ],
    );
  }

  Widget _message() {
    return const Row(
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
    );
  }

  List<Widget> _historyClass() {
    return [
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
      _studentRequest(),
      _tutorReview(),
      ..._rating(),
    ];
  }

  Widget _studentRequest() {
    if (studentRequest == null) {
      return const DetailCard(
        child: Text('No request for lesson'),
      );
    } else {
      return DetailCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Request for lesson'),
            Text(studentRequest!),
          ],
        ),
      );
    }
  }

  Widget _tutorReview() {
    if (tutorReview == null) {
      return const DetailCard(
        child: Text("Tutor haven't reviewed yet"),
      );
    } else {
      return DetailCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Tutor Review'),
            Text(tutorReview!),
          ],
        ),
      );
    }
  }

  List<Widget> _rating() {
    if (rates.isNotEmpty) {
      return rates.map((e) => RatingCard(rate: e)).toList();
    } else {
      return [const RatingCard()];
    }
  }

  List<Widget> _commingClass(BuildContext context) {
    return [
      DetailCard(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            _timeSection(context),
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
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        (studentRequest ?? defaultRequest),
                        softWrap: true,
                        style: const TextStyle(color: Colors.black38),
                      ),
                    ),
                  ],
                )
                //
                )
          ],
        ),
      ),
      _joinMeeting(context)
    ];
  }

  Widget _timeSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          courseTime,
          style: const TextStyle(fontSize: 20),
        ),
        if (cancelable) _cancel(context),
      ],
    );
  }

  Widget _joinMeeting(BuildContext context) {
    return GestureDetector(
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
    );
  }

  Widget _cancel(BuildContext context) {
    return GestureDetector(
      onTap: () => showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: _cancelTitle(),
          content: _cancelReport(),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Later'),
              child: const Text('Later'),
            ),
            TextButton(
              onPressed: () async {
                int statuscode = await cancelLesson(bookingId: id);
                if (statuscode == 200) {
                  Navigator.pop(context, 'Cancel Success');
                } else {
                  Navigator.pop(context, 'Cancel Fail');
                }
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent),
                  color: Colors.white,
                ),
                child: const Text(
                  'Cancel',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
      child: _cancelButton(),
    );
  }

  Widget _cancelButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red),
        color: Colors.white,
      ),
      child: const Text(
        'Cancel',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.red),
      ),
    );
  }

  Widget _cancelTitle() {
    return Column(
      children: [
        ImageNetwork(avatar),
        Text(
          nameTutor,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const Text('Lesson time'),
        Text(
          courseTime,
          style: const TextStyle(fontSize: 20),
        ),
      ],
    );
  }

  Widget _cancelReport() {
    List<String> reasons = [
      'Reschedule at another time',
      'Busy at that time',
      'Asked by the tutor',
      'Other'
    ];

    List<DropdownMenuItem> items = reasons
        .map(
          (e) => DropdownMenuItem(
            value: e,
            child: Text(e),
          ),
        )
        .toList();

    return Form(
      child: ListView(
        children: [
          const Text('Was what the reason cancel this booking?'),
          // Dropdown
          DropdownButtonFormField(
            items: items,
            onChanged: (value) => {},
          ),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Additional notes',
            ),
          ),
        ],
      ),
    );
  }
}

class TutorCard extends StatefulWidget {
  const TutorCard(this.info, {super.key});

  final TutorInfo info;

  @override
  State<TutorCard> createState() => _CardState();
}

class _CardState extends State<TutorCard> {
  String getName() {
    return widget.info.name!.split(' ').map((e) => e[0]).join();
  }

  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.info.isFavoriteTutor ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TutorScreen(widget.info.userId!,
                  feedbacks: widget.info.feedbacks)),
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
                    _avatar(),
                    _info(),
                  ],
                ),
                _favoriteButton(),
              ],
            ),
            Wrap(
              children: [
                for (String tag in formatTagsCard(widget.info.specialties!))
                  TagFilter(tag, isChecked: true),
              ],
            ),
            Text(
              widget.info.bio!,
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

  Widget _avatar() {
    return Container(
      width: 70,
      height: 70,
      margin: const EdgeInsets.only(right: 20),
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(0, 133, 240, 1),
        shape: BoxShape.circle,
      ),
      child: (widget.info.avatar != null)
          ? ImageNetwork(widget.info.avatar)
          : Center(
              child: Text(
                getName(),
                style: const TextStyle(color: Colors.white, fontSize: 40),
              ),
            ),
    );
  }

  Widget _info() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.info.name!,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          children: [
            (widget.info.country != null)
                ? Flag.flagsCode.contains(widget.info.country!.toLowerCase())
                    ? Flag.fromString(
                        widget.info.country!,
                        height: 16,
                        width: 16,
                      )
                    : const Icon(Icons.image_not_supported)
                : const Icon(Icons.image_not_supported),
            Text(widget.info.language ?? ''),
          ],
        ),
        (widget.info.rating != null)
            ? Row(
                children: [
                  for (int i = 1; i <= widget.info.rating!.toInt(); i++)
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
    );
  }

  Widget _favoriteButton() {
    return GestureDetector(
      onTap: () async {
        try {
          await addTutorToFavorite(widget.info.userId!);
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Added tutor to favorite')),
            );
          }
        } catch (e) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('An error occurred: $e')),
            );
          }
        }
        setState(() => isFavorite = !isFavorite);
      },
      child: (isFavorite)
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
    );
  }
}
