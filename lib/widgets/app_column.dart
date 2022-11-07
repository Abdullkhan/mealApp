import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_delivery_app/utilities/colors.dart';
import 'package:food_delivery_app/utilities/dimentions.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/icon_and%20_text_widget.dart';
import 'package:food_delivery_app/widgets/small_text.dart';

class AppColumn extends StatelessWidget {
  final String text;
  AppColumn({required this.text});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(
          text: text,
          size: Dimentions.font20,
        ),
        SizedBox(
          height: Dimentions.height10,
        ),
        Row(
          children: [
            Wrap(
              children: List.generate(
                5,
                (index) => Icon(
                  Icons.star,
                  color: AppColors.mainColor,
                  size: 20,
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            SmallText(text: '4.6'),
            SizedBox(
              width: 10,
            ),
            SmallText(text: '1k cmments'),
          ],
        ),
        SizedBox(
          height: Dimentions.height10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconAndTextWidget(
                icon: Icons.circle_sharp,
                iconColor: AppColors.iconColor1,
                text: 'Normal'),
            IconAndTextWidget(
                icon: Icons.location_on,
                iconColor: AppColors.mainColor,
                text: '1.9 km'),
            IconAndTextWidget(
                icon: Icons.access_time_rounded,
                iconColor: AppColors.iconColor2,
                text: '20 mints'),
          ],
        ),
      ],
    );
  }
}
