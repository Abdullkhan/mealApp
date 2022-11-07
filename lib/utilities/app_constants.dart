import 'package:flutter/animation.dart';

class AppConstants {
  static const String appName = 'Food Delivery';
  static const int appVersion = 1;
  static const String baseUrl = 'http://mvs.bslmeiyu.com';
  static const String popularProductUri = '/api/v1/products/popular';
  static const String recommendedProductUri = '/api/v1/products/recommended';

  //auth end points
  static const String registrationUri = '/api/v1/auth/register';
  static const String loginUri = '/api/v1/auth/login';

  static const String token = '';
  static const String phone = 'phone';
  static const String password = 'password';
  static const String uploadUrl = '/uploads/';
  static const String cart_list = 'cart-list';
  static const String cart_history_list = 'cart_history-list';
}
