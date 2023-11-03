import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test_route/widgets/avatar.dart';
import 'package:test_route/widgets/button.dart';
import 'package:test_route/widgets/footer.dart';
import 'package:test_route/widgets/mainBody.dart';
import 'package:test_route/widgets/pagination.dart';
import 'package:video_player/video_player.dart';

class Detail extends StatelessWidget {
  const Detail(this.name,
      {this.avatar,
      this.tags,
      this.bio,
      this.code,
      this.country,
      this.point = 0,
      this.count = 0,
      this.isLiked = false,
      super.key});

  final String name;
  final String? avatar;
  final List<String>? tags;
  final String? bio;
  final String? code;
  final String? country;
  final int point;
  final int count;
  final bool isLiked;

  String getName() {
    return name.split(' ').map((e) => e[0]).join();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 110,
              height: 110,
              margin: const EdgeInsets.only(right: 20),
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                avatar!,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 110,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      for (int i = 1; i <= point!; i++)
                        const Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 16,
                        ),
                      Text(' ($count)'),
                    ],
                  ),
                  Row(
                    children: [
                      Flag.fromString(
                        code!,
                        height: 22,
                        width: 22,
                      ),
                      Text(country!),
                    ],
                  )
                  /*
                (point != 0)
                    ? Row(
                        children: [
                          for (int i = 1; i <= point!; i++)
                            const Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 16,
                            ),
                          Text(' ($count)'),
                        ],
                      )
                    : const Text(
                        'No reviews yet',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                (country != null)
                    ? Row(
                        children: [
                          Flag.fromString(
                            code!,
                            height: 22,
                            width: 22,
                          ),
                          Text(country!),
                        ],
                      )
                    : const Icon(Icons.image_not_supported),
              */
                ],
              ),
            ),
          ],
        ),
        Text(
          bio!,
          softWrap: true,
          style: const TextStyle(height: 1.5),
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Icon(
                  Icons.favorite_outline_rounded,
                  color: Colors.blue,
                ),
                Text(
                  'Favorite',
                  style: TextStyle(color: Colors.blue),
                ),
              ],
            ),
            Column(
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
          ],
        )
      ],
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key});

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
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
      ),
    );

    _controller = VideoPlayerController.asset('assets/videos/video-tutor.mp4');

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
    super.key,
  });

  final String title;
  final String? description;
  final List<String>? tags;
  final List<String>? contents;

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
            ],
          ),
        ),
      ],
    );
  }
}

class Review extends StatelessWidget {
  const Review(
    this.name, {
    required this.avatar,
    required this.time,
    required this.point,
    this.review,
    super.key,
  });

  final String avatar;
  final String name;
  final String time;
  final int point;
  final String? review;

  Color getStarColor(int i) {
    if (i > point) {
      return Colors.grey;
    } else {
      return Colors.yellow;
    }
  }

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
            child: Image.asset(
              avatar,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: name,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color.fromRGBO(0, 0, 0, 0.45),
                  ),
                  children: [
                    TextSpan(
                      text: time,
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
                      color: getStarColor(i),
                      size: 16,
                    ),
                ],
              ),
              if (review != null)
                const SizedBox(
                  height: 5,
                ),
              if (review != null)
                Text(
                  review!,
                  style: const TextStyle(fontSize: 14, color: Colors.black),
                ),
            ],
          )
        ],
      ),
    );
  }
}

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 35),
      color: Colors.white,
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Detail About Tutor
          Detail(
            'Keegan',
            avatar: 'assets/images/avatar01.jpg',
            point: 5,
            count: 128,
            bio:
                'I am passionate about running and fitness, I often compete in trail/mountain running events and I love pushing myself. I am training to one day take part in ultra-endurance events. I also enjoy watching rugby on the weekends, reading and watching podcasts on Youtube. My most memorable life experience would be living in and traveling around Southeast Asia.',
            code: 'TN',
            country: ' Tunisia',
          ),
          VideoPlayerScreen(),
          // Detail Description
          Part(
            'Education',
            description: 'BA',
          ),
          Part(
            'Languages',
            tags: ['English'],
          ),
          Part(
            'Specialties',
            tags: [
              'English for Business',
              'Conversational',
              'English for kids',
              'IELTS',
              'STARTERS',
              'MOVERS',
              'FLYTERS',
              'KET',
              'PET',
              'TOEFL',
              'TOEIC'
            ],
          ),
          Part(
            'Suggested courses',
            contents: [
              'Basic Conversation Topics',
              'Life in the Internet Age',
            ],
          ),
          Part(
            'Interests',
            description:
                'I loved the weather, the scenery and the laid-back lifestyle of the locals.',
          ),
          Part(
            'Teaching experience',
            description:
                'I have more than 10 years of teaching english experience',
          ),
          // Reviews
          Text(
            'Other review',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
              height: 2.5,
            ),
          ),
          Review(
            'Phhai123',
            avatar: 'assets/images/avatar03.jpeg',
            time: '4 days ago',
            point: 1,
            review: 'DD',
          ),
          Review(
            'Phhai',
            avatar: 'assets/images/avatar04.png',
            time: '8 days ago',
            point: 1,
            review: 'asdfasdf',
          ),
          Review(
            'Phhai',
            avatar: 'assets/images/avatar04.png',
            time: '8 days ago',
            point: 5,
            review: 'asdf',
          ),
          Review(
            'Phhai',
            avatar: 'assets/images/avatar04.png',
            time: '8 days ago',
            point: 3,
            review: 'asdfasdf',
          ),
          Review(
            'Phhai123',
            avatar: 'assets/images/avatar03.jpeg',
            time: '8 days ago',
            point: 5,
          ),
          Review(
            'Phhai123',
            avatar: 'assets/images/avatar03.jpeg',
            time: '8 days ago',
            point: 5,
          ),
          Review(
            'Minh Duc Le',
            avatar: 'assets/images/avatar05.jpg',
            time: '5 months ago',
            point: 5,
            review: 'great jd đ',
          ),
          Pagination(1)
        ],
      ),
    );
  }
}

class TutorScreen extends StatelessWidget {
  const TutorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainBody(Body());
  }
}
