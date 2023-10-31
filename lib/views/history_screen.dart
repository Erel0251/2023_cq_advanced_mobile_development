import 'package:flutter/material.dart';

class Reservation extends StatelessWidget {
  const Reservation(
      {required this.time,
      required this.date,
      required this.status,
      super.key});

  final String time;
  final String date;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      color: const Color.fromRGBO(241, 241, 241, 1),
      child: Column(
        children: [
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            children: [
              Text(
                time,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                date,
                style: const TextStyle(fontSize: 18),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text('Status'),
                  Text(
                    status,
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.all(5),
            color: Colors.white,
            child: const Column(
              children: [],
            ),
          ),
        ],
      ),
    );
  }
}
