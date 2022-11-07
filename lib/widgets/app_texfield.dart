import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_delivery_app/utilities/dimentions.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final IconData icon;
  final TextInputType? keyboardType;
  final bool isObscure;
  

  AppTextField({required this.textController, required this.hintText, required this.icon, this.keyboardType, this.isObscure=false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: Dimentions.height20, right: Dimentions.height20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimentions.height30),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(1, 10),
            blurRadius: 10,
            spreadRadius: 7,
            color: Colors.grey.withOpacity(0.2),
          ),
        ],
      ),
      child: TextField(
       obscureText: isObscure?true:false,
        keyboardType:keyboardType,
        controller: textController,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(icon, color: Colors.yellow),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimentions.radius30),
            borderSide: BorderSide(width: 1, color: Colors.white),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimentions.radius30),
            borderSide: BorderSide(width: 1, color: Colors.white),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(Dimentions.radius30)),
        ),
      ),
    );
  }
}
