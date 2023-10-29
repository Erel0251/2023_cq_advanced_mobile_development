import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test_route/widgets/button.dart';
import 'package:test_route/widgets/footer.dart';

class Banner extends StatelessWidget {
  const Banner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(5)),
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 12, 61, 223),
            Color.fromARGB(255, 5, 23, 157)
          ],
        ),
      ),
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Upcoming lesson',
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
            ),
          ),
          Wrap(
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
          ),
          Container(
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
                    color: Color.fromARGB(255, 12, 61, 223),
                  ),
                ),
              ],
            ),
          ),
          const Text(
            'Total lesson time is 512 hours 55 minutes',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}

class TagCard extends StatelessWidget {
  const TagCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Wrap(
      children: [
        TagFilter('All', isChecked: true),
        TagFilter('English for kids'),
        TagFilter('English for Business'),
        TagFilter('Conversational'),
        TagFilter('STARTERS'),
        TagFilter('MOVERS'),
        TagFilter('FLYERS'),
        TagFilter('KET'),
        TagFilter('PET'),
        TagFilter('IELTS'),
        TagFilter('TOEFL'),
        TagFilter('TOEIC'),
      ],
    );
  }
}

class Card extends StatelessWidget {
  const Card(this.name,
      {this.tags, this.bio, this.country, this.point, super.key});
  final String name;
  final String? bio;
  final String? country;
  final int? point;
  final List<String>? tags;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.do_disturb),
                  Column(
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      (country != null)
                          ? Flag.fromString(country!)
                          : const Icon(Icons.image_not_supported),
                      (point != 0)
                          ? Row(
                              children: [
                                for (int i = 1; i <= point!; i++)
                                  const Icon(
                                    Icons.star,
                                    color: Colors.yellow,
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
              const Icon(Icons.favorite),
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
      margin: const EdgeInsets.all(20),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Find a tutor',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          TagCard(),
          ResetFilterButton('Reset Filter'),
          Divider(
            color: Colors.black54,
          ),
          Text(
            'Recommended Tutors',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          Card(
            'Keegan',
            tags: [
              'English for Business',
              'Conversational',
              'English for kids',
              'IELTS',
              'STARTERS',
              'MOVERS',
              'FLYTERS',
              'KET',
            ],
            bio:
                'I am passionate about running and fitness, I often compete in trail/mountain running events and I love pushing myself. I am training to one day take part in ultra-endurance events. I also enjoy watching rugby on the weekends, reading and watching podcasts on Youtube. My most memorable life experience would be living in and traveling around Southeast Asia.',
            point: 5,
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.white,
        title: SvgPicture.asset(
          'assets/images/lettutor_logo.svg',
          width: 150.0,
          fit: BoxFit.fitWidth,
        ),
        actions: const <Widget>[
          LanguageButton(),
          MenuButton(),
        ],
      ),
      body: ListView(
        children: const [
          Banner(),
          Body(),
          Footer(),
        ],
      ),
      floatingActionButton: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: <Widget>[
          FloatingActionButton(
            backgroundColor: Color.fromRGBO(128, 128, 128, 1),
            onPressed: () {},
            child: const Icon(Icons.chat_outlined),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 80),
            child: FloatingActionButton(
              backgroundColor: Color.fromRGBO(128, 128, 128, 1),
              onPressed: () {},
              child: const Icon(Icons.card_giftcard),
            ),
          ),
        ],
      ),
    );
  }
}
