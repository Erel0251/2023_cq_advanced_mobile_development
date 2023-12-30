import 'package:flag/flag.dart';
import 'package:flutter/material.dart';

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
                      for (int i = 1; i <= point; i++)
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
