import 'package:flutter/material.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/controllers/popular_products_controller.dart';
import 'package:food_delivery_app/controllers/recommended_products_controller.dart';
import 'package:food_delivery_app/home/main_food_page.dart';
import 'package:food_delivery_app/routes/app_routes.dart';
import 'package:food_delivery_app/screens/auth/sign_in.dart';
import 'package:food_delivery_app/screens/auth/sign_up.dart';
import 'package:food_delivery_app/screens/cart/cart_page.dart';
import 'package:food_delivery_app/screens/food/food_details.dart';
import 'package:food_delivery_app/screens/food/recommended_food_details.dart';
import 'package:get/get.dart';
import 'helpers/dependencies.dart' as dep;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();

    return GetBuilder<PopularProductsController>(builder: (_) {
      return GetBuilder<RecommendedProductsController>(builder: (_) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          //home: SignIn(),
          initialRoute: Approutes.getSplashScreen(),
          getPages: Approutes.routes,
        );
      });
    });
  }
}
