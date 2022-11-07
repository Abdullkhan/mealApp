import 'dart:convert';

import 'package:food_delivery_app/models/cart_model.dart';
import 'package:food_delivery_app/utilities/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;
  CartRepo({required this.sharedPreferences});

  List<String> cart = [];
  List<String> cartHistory = [];

  void addToCartList(List<CartModel> cartList) {
    // sharedPreferences.remove(AppConstants.cart_list);
    // sharedPreferences.remove(AppConstants.cart_history_list);
    var time = DateTime.now().toString();
    cart = [];
    cartList.forEach((element) {
      element.time = time;
      return cart.add(jsonEncode(element));
    });
    sharedPreferences.setStringList(AppConstants.cart_list, cart);
    //print(sharedPreferences.getStringList(AppConstants.cart_list));
    getCartListintoObject();
  }

  List<CartModel> getCartListintoObject() {
    List<String> carts = [];

    if (sharedPreferences.containsKey(AppConstants.cart_list)) {
      carts = sharedPreferences.getStringList(AppConstants.cart_list)!;
      print('inside the method' + cart.toString());
    }
    List<CartModel> cartList = [];
    carts.forEach((element) {
      cartList.add(CartModel.fromJson(json.decode(element)));
    });

    return cartList;
  }

  List<CartModel> getCartHistoryList() {
    if (sharedPreferences.containsKey(AppConstants.cart_history_list)) {
      cartHistory = [];
      cartHistory = sharedPreferences.getStringList(AppConstants.cart_history_list)!;
    }
    List<CartModel> cartListHistory = [];
    cartHistory.forEach((element) => cartListHistory.add(CartModel.fromJson(jsonDecode(element))));
    return cartListHistory;
  }

  void addToCartHistoryList() {
    if (sharedPreferences.containsKey(AppConstants.cart_history_list)) {
      cartHistory = sharedPreferences.getStringList(AppConstants.cart_history_list)!;
    }
    for (int i = 0; i < cart.length; i++) {
      // print('History list is ' + cart[i]);
      cartHistory.add(cart[i]);
    }
    removeCart();
    sharedPreferences.setStringList(AppConstants.cart_history_list, cartHistory);
    for (int j = 0; j < getCartHistoryList().length; j++) {
      print('The time of each item is ' + getCartHistoryList()[j].time.toString());
    }
    print('the length of history of list is ' + getCartHistoryList().length.toString());
  }

  void removeCart() {
    cart = [];
    sharedPreferences.remove(AppConstants.cart_list);
  }
  
}
