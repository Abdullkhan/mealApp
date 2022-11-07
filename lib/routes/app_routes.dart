import 'package:flutter/animation.dart';
import 'package:food_delivery_app/home/home_page.dart';
import 'package:food_delivery_app/home/main_food_page.dart';
import 'package:food_delivery_app/screens/auth/sign_in.dart';
import 'package:food_delivery_app/screens/cart/cart_page.dart';
import 'package:food_delivery_app/screens/food/food_details.dart';
import 'package:food_delivery_app/screens/food/recommended_food_details.dart';
import 'package:food_delivery_app/screens/splash/splash_screen.dart';
import 'package:get/get.dart';

class Approutes {
  static const String splashScreen = '/splash-screen';
  static const String initialRoute = '/';
  static const String foodDetails = '/popular-food';
  static const String recommendedFood = '/recommended-food';
  static const String cartPage = '/cart-page';
  static const String signIn = '/sign-in';

  static String getSplashScreen() => '$splashScreen';
  static String getinitialRoute() => '$initialRoute';
  static String getFoodDetails(int pageId, String page) => '$foodDetails?pageId=$pageId&page=$page';
  static String getRecommendedFoodRoute(int pageId, String page) => '$recommendedFood?pageId=$pageId&page=$page';
  static String getCartPage() => '$cartPage';
  static String getSignInPage() => '$signIn';

  static List<GetPage> routes = [
    GetPage(name: splashScreen, page: () => SplashScreen()),
    GetPage(name: initialRoute, page: () => HomePage()),
    GetPage(
      name: foodDetails,
      page: () {
        var pageId = Get.parameters['pageId'];
        var page = Get.parameters['page'];

        return FoodDetails(
          pageId: int.parse(pageId!),
          page: page!,
        );
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: recommendedFood,
      page: () {
        var pageId = Get.parameters['pageId'];
        var page = Get.parameters['page'];
        return RecommendedFoodDetails(pageId: int.parse(pageId!), page: page!);
      },
    ),
    GetPage(
        name: cartPage,
        page: () {
          return CartPage();
        },
        transition: Transition.fadeIn),
    GetPage(
      name: signIn,
      page: () {
        return SignIn();
      },
      transition: Transition.fade,
    ),
  ];
}
