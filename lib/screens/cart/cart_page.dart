import 'package:flutter/material.dart';
import 'package:food_delivery_app/base/no_data_page.dart';
import 'package:food_delivery_app/controllers/auth_controller.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/controllers/popular_products_controller.dart';
import 'package:food_delivery_app/controllers/recommended_products_controller.dart';
import 'package:food_delivery_app/home/main_food_page.dart';
import 'package:food_delivery_app/routes/app_routes.dart';
import 'package:food_delivery_app/screens/food/food_details.dart';
import 'package:food_delivery_app/utilities/app_constants.dart';
import 'package:food_delivery_app/utilities/colors.dart';
import 'package:food_delivery_app/utilities/dimentions.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/small_text.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: Dimentions.height30 * 2,
            left: Dimentions.width20,
            right: Dimentions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(
                  icon: Icons.arrow_back_ios,
                  backgroundColor: AppColors.mainColor,
                  iconColor: Colors.white,
                  iconSize: Dimentions.iconSize24,
                ),
                SizedBox(
                  width: Dimentions.width30 * 5,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Approutes.getinitialRoute());
                  },
                  child: AppIcon(
                    icon: Icons.home_outlined,
                    backgroundColor: AppColors.mainColor,
                    iconColor: Colors.white,
                    iconSize: Dimentions.iconSize24,
                  ),
                ),
                AppIcon(
                  icon: Icons.shopping_cart,
                  backgroundColor: AppColors.mainColor,
                  iconColor: Colors.white,
                  iconSize: Dimentions.iconSize24,
                ),
              ],
            ),
          ),
          GetBuilder<CartController>(builder: (_cartController) {
            return _cartController.getItemsforCartPage.length > 0
                ? Positioned(
                    top: Dimentions.height20 * 5,
                    left: Dimentions.width10,
                    right: Dimentions.width20,
                    bottom: 0,
                    child: Container(
                      margin: EdgeInsets.only(top: Dimentions.height20),
                      child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: GetBuilder<CartController>(
                          builder: (CartControllerInstance) {
                            var _cartList = CartControllerInstance.getItemsforCartPage;

                            return ListView.builder(
                              itemCount: _cartList.length,
                              itemBuilder: (_, index) {
                                return Container(
                                  height: 100,
                                  width: double.maxFinite,
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          int productIndex =
                                              Get.find<PopularProductsController>().popularProductsList.indexOf(
                                                    _cartList[index].product!,
                                                  );
                                          if (productIndex >= 0) {
                                            Get.toNamed(
                                              Approutes.getFoodDetails(
                                                productIndex,
                                                'cartPage',
                                              ),
                                            );
                                          } else {
                                            int recommendedIndex = Get.find<RecommendedProductsController>()
                                                .recommendedProductList
                                                .indexOf(_cartList[index].product!);
                                            if (recommendedIndex < 0) {
                                              Get.snackbar('History Product',
                                                  'Product review is not availabe for history products');
                                            } else {
                                              Get.toNamed(
                                                Approutes.getRecommendedFoodRoute(recommendedIndex, 'cartPage'),
                                              );
                                            }
                                          }
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(bottom: Dimentions.height10),
                                          width: Dimentions.height20 * 5,
                                          height: Dimentions.height20 * 5,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(AppConstants.baseUrl +
                                                  AppConstants.uploadUrl +
                                                  CartControllerInstance.getItemsforCartPage[index].img!),
                                            ),
                                            borderRadius: BorderRadius.circular(Dimentions.radius20),
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.only(left: Dimentions.width10),
                                          height: Dimentions.height20 * 5,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              BigText(text: CartControllerInstance.getItemsforCartPage[index].name!),
                                              SmallText(text: 'tasty'),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  BigText(
                                                    text: CartControllerInstance.getItemsforCartPage[index].price
                                                        .toString(),
                                                    color: Colors.redAccent,
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(left: 20),
                                                    padding: EdgeInsets.only(
                                                      left: Dimentions.width10,
                                                      right: Dimentions.width10,
                                                      top: Dimentions.height10,
                                                      bottom: Dimentions.height10,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.circular(Dimentions.radius20),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            CartControllerInstance.addItems(
                                                              _cartList[index].product!,
                                                              1,
                                                            );
                                                          },
                                                          child: Icon(Icons.add),
                                                        ),
                                                        SizedBox(width: 5),
                                                        BigText(
                                                          text: _cartList[index].quantity.toString(),
                                                        ), //(inCartItems.toString()),
                                                        SizedBox(width: 5),
                                                        GestureDetector(
                                                          onTap: () {
                                                            CartControllerInstance.addItems(
                                                              _cartList[index].product!,
                                                              -1,
                                                            );
                                                          },
                                                          child: Icon(Icons.remove),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  )
                : NoDataPage(
                    text: 'Your Cart is empty',
                    imagePath: 'assets/images/emptycart.png',
                  );
          }),
        ],
      ),
      bottomNavigationBar: GetBuilder<CartController>(
        builder: (cartControllerInstance) {
          return Container(
            height: Dimentions.bottomNavigationBarHeight,
            padding: EdgeInsets.only(top: Dimentions.height20, bottom: Dimentions.height20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: AppColors.buttonBackgroundColor),
            child: cartControllerInstance.getItemsforCartPage.length > 0
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 20),
                        padding: EdgeInsets.only(
                          left: Dimentions.width20,
                          right: Dimentions.width20,
                          top: Dimentions.height20,
                          bottom: Dimentions.height20,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(Dimentions.radius20),
                        ),
                        child: Row(
                          children: [
                            BigText(
                              text: '\$ ' + cartControllerInstance.totalAmount.toString(),
                            ),
                            SizedBox(width: 5),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: Dimentions.width10),
                        padding: EdgeInsets.only(
                          left: Dimentions.width20,
                          right: Dimentions.width20,
                          top: Dimentions.height20,
                          bottom: Dimentions.height20,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimentions.radius20),
                          color: AppColors.mainColor,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            if (Get.find<AuthController>().userLoggedIn()) {
                              cartControllerInstance.addToCartHistory();
                            } else {
                              Get.toNamed(Approutes.getSignInPage());
                            }
                          },
                          child: BigText(text: 'Check out'),
                        ),
                      ),
                    ],
                  )
                : Container(),
          );
        },
      ),
    );
  }
}
