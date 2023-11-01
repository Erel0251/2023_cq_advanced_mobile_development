import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class CallScreen extends StatelessWidget {
  const CallScreen({super.key});

  final double edge = 45;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black87,
        alignment: Alignment.center,
        child: Container(
          width: 200,
          height: 200,
          margin: const EdgeInsets.only(right: 20),
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(
            color: Colors.orange,
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Text(
              'P',
              style: TextStyle(color: Colors.white, fontSize: 100),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.black87,
        child: Container(
          margin: const EdgeInsets.all(10),
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(8)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: edge,
                height: edge,
                alignment: Alignment.center,
                child: const Icon(
                  Icons.mic_none_outlined,
                  color: Colors.white,
                ),
              ),
              Container(
                width: edge,
                height: edge,
                alignment: Alignment.center,
                child: const Icon(
                  Icons.videocam_off_outlined,
                  color: Colors.white,
                ),
              ),
              Container(
                width: edge,
                height: edge,
                alignment: Alignment.center,
                child: const Icon(
                  Icons.screen_share_outlined,
                  color: Colors.white,
                ),
              ),
              Container(
                width: edge,
                height: edge,
                alignment: Alignment.center,
                child: const Icon(
                  Icons.back_hand_outlined,
                  color: Colors.white,
                ),
              ),
              Container(
                width: edge,
                height: edge,
                alignment: Alignment.center,
                child: const Icon(
                  Icons.zoom_out_map_rounded,
                  color: Colors.white,
                ),
              ),
              Container(
                width: edge,
                height: edge,
                alignment: Alignment.center,
                child: const Icon(
                  Icons.circle_outlined,
                  color: Colors.white,
                ),
              ),
              Container(
                width: edge,
                height: edge,
                alignment: Alignment.center,
                child: const Icon(
                  Icons.more_horiz_outlined,
                  color: Colors.white,
                ),
              ),
              Container(
                width: edge,
                height: edge,
                color: Colors.red,
                alignment: Alignment.center,
                child: const Icon(
                  Icons.call_end_outlined,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(128, 128, 128, 1),
        onPressed: () {},
        child: const Icon(Icons.chat_outlined),
      ),
    );
  }
}
