import 'package:flutter/material.dart';

class ProgressHeader extends StatelessWidget {
  final String message;
  final double progressWidth;

  const ProgressHeader({
    Key? key,
    required this.message,
    required this.progressWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 30,
          color: Color(0xFFF4E9D1),
        ),
        Positioned(
          left: 0,
          child: Container(
            width: progressWidth,
            height: 50,
            color: Color(0xFFE7B958),
          ),
        ),
        Container(
          height: 30,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 20),
          child: Text(
            message,
            style: TextStyle(
              fontFamily: 'SansSerif',
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}