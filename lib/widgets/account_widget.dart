import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/utilities/dimentions.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/big_text.dart';

class AccountWidget extends StatelessWidget {
  AccountWidget({required this.appIcon, required this.bigText});
  AppIcon appIcon;
  BigText bigText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: Dimentions.width20,
        top: Dimentions.height10,
        bottom: Dimentions.height10,
      ),
      child: Row(
        children: [
          appIcon,
          SizedBox(width: Dimentions.width20),
          bigText,
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            offset: Offset(0, 2),
            color: Colors.grey.withOpacity(0.3),
          ),
        ],
      ),
    );
  }
}
