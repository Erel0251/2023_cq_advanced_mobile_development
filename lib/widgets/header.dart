import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class Header extends StatelessWidget {
  const Header(this.title,
      {required this.descriptions, required this.image, super.key});

  final String image;
  final String title;
  final List<String> descriptions;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _image(),
        _headerTitle(),
        _descriptions(),
      ],
    );
  }

  Widget _image() {
    return SvgPicture.asset(
      image,
      width: 100,
      height: 100,
    );
  }

  Widget _headerTitle() {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        height: 1.5,
      ),
    );
  }

  Widget _descriptions() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: const BoxDecoration(
        border: Border(left: BorderSide(color: Colors.black12, width: 4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (String description in descriptions) _description(description),
        ],
      ),
    );
  }

  Widget _description(String description) {
    return Text(
      description,
      softWrap: true,
      style: const TextStyle(fontSize: 18),
    );
  }
}

class DiscoverCoursesHeader extends StatelessWidget {
  const DiscoverCoursesHeader(this.title,
      {required this.description, required this.image, super.key});

  final String image;
  final String title;
  final String description;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _image(),
            _header(),
          ],
        ),
        const SizedBox(height: 20),
        _description(),
      ],
    );
  }

  Widget _image() {
    return SvgPicture.asset(
      image,
      width: 100,
      height: 100,
    );
  }

  Widget _header() {
    return Container(
      height: 100,
      margin: const EdgeInsets.only(left: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _headTitle(),
          _searchField(),
        ],
      ),
    );
  }

  Widget _description() {
    return Text(
      description,
      softWrap: true,
      style: const TextStyle(fontSize: 14),
    );
  }

  Widget _headTitle() {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        height: 1.5,
      ),
    );
  }

  Widget _searchField() {
    return const SizedBox(
      width: 200,
      height: 36,
      child: TextField(
        decoration: InputDecoration(
          isDense: true,
          hintText: "Course",
          contentPadding: EdgeInsets.symmetric(horizontal: 14),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
          suffixIcon: Icon(Icons.search),
        ),
      ),
    );
  }
}
