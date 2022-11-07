import 'package:get/get.dart';

class Dimentions {
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;

  static double mainContainer = screenHeight / 2.81;
  static double pageViewContainer = screenHeight / 3.83;
  static double pageViewTextContainer = screenHeight / 7.0;

// heights for padding and margin
  static double height10 = screenHeight / 84.3;
  static double height20 = screenHeight / 42.15;
  static double height30 = screenHeight / 28.01;
  static double height40 = screenHeight / 21.075;
  static double height45 = screenHeight / 18.73;
  static double height250 = screenHeight / 3.37;

  //width for padding and margin

  static double width10 = screenHeight / 84.3;
  static double width20 = screenHeight / 42.15;
  static double width30 = screenHeight / 28.01;
  static double width40 = screenHeight / 21.075;
  static double width45 = screenHeight / 18.73;

  //fontsize
  static double font16 = screenHeight / 52.6;
  static double font20 = screenHeight / 42.15;
  static double font30 = screenHeight / 28.1;

  // radius
  static double radius15 = screenHeight / 56.02;
  static double radius20 = screenHeight / 42.15;
  static double radius30 = screenHeight / 28.1;

  //icon size

  static double iconSize24 = screenHeight / 35.125;
  static double iconSize15 = screenHeight / 56.2;

  //listview image

  static double listViewImageSize = screenWidth / 3.42;
  static double listViewTextContainer = screenWidth / 4.11;

  // food details

  static double foodDetailImageSize = screenHeight / 2.40;

  // bottom navigationbar height in food_details.dart

  static double bottomNavigationBarHeight = screenHeight / 7.05;
}
