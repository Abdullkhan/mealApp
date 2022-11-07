import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_delivery_app/utilities/dimentions.dart';

class NoDataPage extends StatelessWidget {
  NoDataPage({required this.text, this.imagePath});
  String text;
  String? imagePath;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset(
          imagePath!,
          height: Dimentions.height250,
          width: 100,
        ),
        SizedBox(
          height: Dimentions.height20,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: Dimentions.font20,
            color: Theme.of(context).disabledColor,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
