import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_delivery_app/controllers/popular_products_controller.dart';
import 'package:food_delivery_app/controllers/recommended_products_controller.dart';
import 'package:food_delivery_app/home/home_page.dart';
import 'package:food_delivery_app/routes/app_routes.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

Future<void> _loadResources() async {
  await Get.find<PopularProductsController>().getPopularProductsList();
  await Get.find<RecommendedProductsController>().getRecommendedProductList();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late Animation animation;
  late AnimationController controller;
  @override
  void initState() {
    _loadResources();
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2))
          ..forward();
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);

    Timer(
        Duration(seconds: 3), () => Get.offNamed(Approutes.getinitialRoute()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: ScaleTransition(
              scale: controller,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/images/burger.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                height: 150,
                width: 150,
              ),
            ),
          ),
          Container(
              height: 150,
              width: 350,
              child: Center(child: Image.asset('assets/images/foodlogo.png'))),
        ],
      ),
    );
  }
}
