import 'dart:convert';

import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'package:test_route/models/tutor.dart';
import 'package:test_route/utils/format_tags_card.dart';
import 'package:test_route/views/tutor_screen.dart';
import 'package:test_route/widgets/button.dart';
import 'package:test_route/widgets/body.dart';
import 'package:test_route/widgets/pagination.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MainBody(
      ChangeNotifierProvider(
        create: (context) => SearchModel(),
        child: const Body(),
      ),
    );
  }
}

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late Future<ResponseTutors> futureTutorsInfo;

  @override
  void initState() {
    super.initState();
    futureTutorsInfo = fetchTutorsInfo();
  }

  Future<ResponseTutors> fetchTutorsInfo() async {
    final String baseUrl = dotenv.env['BASE_URL'] ?? '';
    final String token = dotenv.env['AUTH_TOKEN'] ?? '';

    final response = await http.get(
      Uri.parse('${baseUrl}tutor/more?perPage=9&page=1'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final ResponseTutors responseTutors = ResponseTutors.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
      return responseTutors;
    } else {
      throw Exception('Failed to load tutors');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchModel>(
      builder: (context, searchModel, child) {
        return Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Banner(),
              // Search section
              ...searchSection(searchModel),
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
              //...cards(searchModel),
              FutureBuilder<ResponseTutors>(
                future: futureTutorsInfo,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ChangeNotifierProvider(
                        create: (context) => SearchModel(),
                        child: Column(
                          children: [
                            ...cards(searchModel, snapshot.data!),
                          ],
                        ));
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
      },
    );
  }

  List<Card> cards(SearchModel searchModel, ResponseTutors data) {
    List<Card> original = data.tutors.row
        .map((e) => Card(
              e.userId!,
              name: e.name!,
              avatar: e.avatar,
              tags: formatTagsCard(e.specialties!),
              bio: e.bio,
              point: e.rating != null ? e.rating!.toInt() : 0,
              // check data.favoriteTutors if its secondId contains e.userId
              isLiked: data.favoriteTutors!
                  .map((e) => e.secondId)
                  .contains(e.userId),
              code: e.country,
              country: e.language,
            ))
        .toList();

    original = original
        .where((card) =>
            card.name.toLowerCase().contains(searchModel.name.toLowerCase()) &&
            (card.tags!.contains(searchModel.tag) || searchModel.tag == 'All'))
        .toList();
    return original..sort((a, b) => a.isLiked ? 0 : 1);
  }

  List<Widget> searchSection(SearchModel searchModel) {
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
          SizedBox(
            width: 165,
            child: TextField(
              // if searchModel.name is not empty, then the textfield will be filled with that value
              onChanged: (value) {
                searchModel.setName(value);
              },
              controller: TextEditingController(text: searchModel.name),
              style: const TextStyle(fontSize: 14, color: Colors.black),
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                hintText: 'Search by name',
                isDense: true, // Added this
                contentPadding: EdgeInsets.all(8),
              ),
            ),
          ),
          SizedBox(
            width: 165,
            child: TextField(
              onChanged: (value) {
                searchModel.setNationlity(value);
              },
              controller: TextEditingController(text: searchModel.nationality),
              style: const TextStyle(fontSize: 14, color: Colors.black),
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                hintText: 'Select tutor nationality',
                isDense: true, // Added this
                contentPadding: EdgeInsets.all(8),
              ),
            ),
          ),
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
      const Wrap(
        spacing: 10,
        children: [
          SizedBox(
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
          ),
          SizedBox(
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
          ),
        ],
      ),
      TagCard(selectedTag: searchModel.tag),
      ResetFilterButton('Reset Filter', onPressed: () {
        searchModel.resetFilter();
      }),
    ];
  }
}

class SearchModel extends ChangeNotifier {
  String name = '';
  String tag = 'All';
  String date = '';
  String nationality = '';

  void setName(String name) {
    this.name = name;
    notifyListeners();
  }

  void setTag(String tag) {
    this.tag = tag;
    notifyListeners();
  }

  void setDate(String date) {
    this.date = date;
    notifyListeners();
  }

  void setNationlity(String nationality) {
    this.nationality = nationality;
    notifyListeners();
  }

  void resetFilter() {
    name = '';
    tag = 'All';
    date = '';
    nationality = '';
    notifyListeners();
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

class TagCard extends StatelessWidget {
  const TagCard({super.key, this.selectedTag = 'All'});
  final List<String> tags = const [
    'All',
    'English for kids',
    'English for Business',
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

  final String selectedTag;

  @override
  Widget build(BuildContext context) {
    // return list of tags, wrap in a gesture detector
    // which will change the selected tag and setstate on it
    // and then the tag will be rebuilt
    return Wrap(
      children: tags
          .map((tag) => GestureDetector(
                onTap: () {
                  Provider.of<SearchModel>(context, listen: false).setTag(tag);
                },
                child: TagFilter(tag, isChecked: tag == selectedTag),
              ))
          .toList(),
    );
  }
}

class Card extends StatelessWidget {
  const Card(
    this.id, {
    required this.name,
    this.avatar,
    this.tags,
    this.bio,
    this.code,
    this.country,
    this.point = 0,
    this.isLiked = false,
    super.key,
  });

  final String id;
  final String name;
  final String? avatar;
  final List<String>? tags;
  final String? bio;
  final String? code;
  final String? country;
  final int point;
  final bool isLiked;

  String getName() {
    return name.split(' ').map((e) => e[0]).join();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const TutorScreen()),
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
                      child: (avatar != null)
                          ? Image.network(
                              avatar!,
                              fit: BoxFit.cover,
                            )
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
                          name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
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
                        (point != 0)
                            ? Row(
                                children: [
                                  for (int i = 1; i <= point; i++)
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
                for (String tag in tags!) TagFilter(tag, isChecked: true),
              ],
            ),
            Text(
              bio!,
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
