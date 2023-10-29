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
      {this.avatar,
      this.tags,
      this.bio,
      this.code,
      this.country,
      this.point = 0,
      this.isLiked = false,
      super.key});

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
    return Container(
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
                        ? Image.asset(
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
                                for (int i = 1; i <= point!; i++)
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
                    borderRadius: const BorderRadius.all(Radius.circular(16))),
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
            avatar: 'assets/images/avatar01.jpg',
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
            isLiked: true,
            code: 'TN',
            country: ' Tunisia',
          ),
          Card(
            'Adelia Rice',
            tags: ['', '', '', '', ''],
            bio: 'Recusandae dignissimos ut commodi et iste qui eum quos.',
          ),
          Card(
            'Allison Murray',
            tags: ['', '', '', '', ''],
            bio: 'Odit est ratione et dolorem tenetur illum.',
          ),
          Card(
            'Ana Lubowitz',
            tags: ['', ''],
            bio: 'Debitis distinctio minus qui accusantium voluptatum.',
          ),
          Card(
            'Angus Dickinson',
            tags: ['', '', '', '', ''],
            bio: 'Enim expedita explicabo saepe perferendis est et.',
          ),
          Card(
            'April Baldo',
            avatar: 'assets/images/avatar02.jpg',
            tags: ['English for Business', 'IELTS', 'PET', 'KET'],
            bio:
                'Hello! My name is April Baldo, you can just call me Teacher April. I am an English teacher and currently teaching in senior high school. I have been teaching grammar and literature for almost 10 years. I am fond of reading and teaching literature as one way of knowing one’s beliefs and culture. I am friendly and full of positivity. I love teaching because I know each student has something to bring on. Molding them to become an individual is a great success.',
            point: 5,
            code: 'PH',
            country: ' Philippines (the)',
          ),
          Card(
            'Bradley Zieme',
            tags: ['', ''],
            bio: 'Asperiores cupiditate sint et neque quasi.',
          ),
          Card(
            'Cassandre Balistreri',
            tags: ['', '', ''],
            bio: 'Est et vel',
          ),
          Card(
            'Chad Ankunding',
            tags: ['', '', '', ''],
            bio: 'Rem neque quidem aliquam magni quasi et.',
          ),
          Card(
            'Damon Carroll',
            tags: ['', '', ''],
            bio:
                'Tenetur sit dolorem qui aspernatur suscipit fugit sequi facere.',
          ),
          Card(
            'Dangelo Wehner',
            tags: ['', '', ''],
            bio: 'Quibusdam nam sint in aut et eius.',
          ),
          Card(
            'David Nikolaus',
            tags: ['', '', '', ''],
            bio: 'Ut autem possimus ipsum esse.',
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
