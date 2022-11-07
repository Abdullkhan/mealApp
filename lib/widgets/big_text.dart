import 'package:flutter/material.dart';
import 'package:food_delivery_app/utilities/dimentions.dart';

class BigText extends StatelessWidget {
  final String text;
  Color color;
  double size;
  TextOverflow textOverflow;

  BigText({
    required this.text,
    this.color = const Color(0xFF332d2b),
    this.size = 0,
    this.textOverflow = TextOverflow.ellipsis,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: textOverflow,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontFamily: 'Roboto',
        fontSize: size == 0 ? Dimentions.font20 : size,
        color: color,
      ),
    );
  }
}
