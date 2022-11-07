import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_delivery_app/base/no_data_page.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/models/cart_model.dart';
import 'package:food_delivery_app/routes/app_routes.dart';
import 'package:food_delivery_app/screens/splash/splash_screen.dart';
import 'package:food_delivery_app/utilities/app_constants.dart';
import 'package:food_delivery_app/utilities/colors.dart';
import 'package:food_delivery_app/utilities/dimentions.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList = Get.find<CartController>().getCartHistoryList().reversed.toList();
    Map<String, int> cartItemsPerOrder = Map();

    for (int i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemsPerOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemsPerOrder.update(getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }
    List<int> cartOrderTimeToList() {
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<String> cardOrderTimeInString() {
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }

    List<int> orderTimes = cartOrderTimeToList();

    var listCounter = 0;

    Widget timeWidget(int index) {
      var outPutDate = DateTime.now().toString();
      if (index < getCartHistoryList.length) {
        DateTime parseDate = DateFormat('yyyy-MM-dd HH:mm:ss').parse(getCartHistoryList[listCounter].time!);
        var date = DateTime.parse(parseDate.toString());
        var outPutFormat = DateFormat('MM/dd/yyyy hh:mm a');
        outPutDate = outPutFormat.format(date);
      }

      return BigText(text: outPutDate);
    }

    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: Dimentions.height30),
            height: Dimentions.height10 * 10,
            color: AppColors.mainColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(
                  text: 'Cart History',
                  color: Colors.white,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          GetBuilder<CartController>(builder: (_cartController) {
            return _cartController.getCartHistoryList().length > 0
                ? Expanded(
                    child: Container(
                      margin: EdgeInsets.only(
                        top: Dimentions.height20,
                        right: Dimentions.height20,
                        left: Dimentions.height20,
                      ),
                      child: MediaQuery.removePadding(
                        removeTop: true,
                        context: context,
                        child: ListView(
                          children: [
                            for (int i = 0; i < orderTimes.length; i++)
                              Container(
                                margin: EdgeInsets.only(bottom: Dimentions.height20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    timeWidget(listCounter),
                                    SizedBox(
                                      height: Dimentions.height20,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Wrap(
                                          direction: Axis.horizontal,
                                          children: List.generate(
                                            orderTimes[i],
                                            (index) {
                                              if (listCounter < getCartHistoryList.length) {
                                                listCounter++;
                                              }
                                              return index <= 2
                                                  ? Container(
                                                      height: Dimentions.height20 * 4,
                                                      width: Dimentions.height20 * 4,
                                                      margin: EdgeInsets.only(
                                                        right: Dimentions.height10 / 2,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(
                                                          Dimentions.height10,
                                                        ),
                                                        image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: NetworkImage(AppConstants.baseUrl +
                                                              AppConstants.uploadUrl +
                                                              getCartHistoryList[listCounter - 1].img!),
                                                        ),
                                                      ),
                                                    )
                                                  : Container();
                                            },
                                          ),
                                        ),
                                        Container(
                                          height: 80,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SmallText(
                                                text: 'Total',
                                                color: AppColors.titleColor,
                                              ),
                                              BigText(
                                                text: orderTimes[i] == 1
                                                    ? orderTimes[i].toString() + ' item'
                                                    : orderTimes[i].toString() + ' items',
                                                color: AppColors.titleColor,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  var orderTiming = cardOrderTimeInString();
                                                  Map<int, CartModel> moreOrder = {};
                                                  for (int j = 0; j < getCartHistoryList.length; j++) {
                                                    if (getCartHistoryList[j].time == orderTiming[i]) {
                                                      moreOrder.putIfAbsent(
                                                          getCartHistoryList[j].id!,
                                                          () => CartModel.fromJson(
                                                              jsonDecode(jsonEncode(getCartHistoryList[j]))));
                                                    }
                                                  }
                                                  Get.find<CartController>().setItems = moreOrder;
                                                  Get.find<CartController>().addToCartList();
                                                  Get.toNamed(Approutes.getCartPage());
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: Dimentions.width10,
                                                    vertical: Dimentions.height10 / 2,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      width: 1,
                                                      color: AppColors.mainColor,
                                                    ),
                                                    borderRadius: BorderRadius.circular(
                                                      Dimentions.radius15 / 2,
                                                    ),
                                                  ),
                                                  child: SmallText(
                                                    text: 'one more',
                                                    color: AppColors.mainColor,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: Container(
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: NoDataPage(
                            text: 'You didn\'t but anything as of now', imagePath: 'assets/images/emptybox.png')),
                  );
          }),
        ],
      ),
    );
  }
}
