import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  Color? color;
  double size;
  final String text;
  double? height;

  SmallText({
    this.color = const Color(0xFFccc7c5),
    this.size = 12,
    required this.text,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        fontFamily: 'Roboto',
        height: height,
        color: color,
      ),
    );
  }
}
