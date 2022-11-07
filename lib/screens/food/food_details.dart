import 'package:flutter/material.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/controllers/popular_products_controller.dart';
import 'package:food_delivery_app/routes/app_routes.dart';
import 'package:food_delivery_app/screens/cart/cart_page.dart';
import 'package:food_delivery_app/utilities/app_constants.dart';
import 'package:food_delivery_app/utilities/colors.dart';
import 'package:food_delivery_app/utilities/dimentions.dart';
import 'package:food_delivery_app/widgets/app_column.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/expandable_text_widget.dart';
import 'package:get/get.dart';

class FoodDetails extends StatelessWidget {
  final int pageId;
  final String page;

  FoodDetails({
    required this.pageId,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<PopularProductsController>().popularProductsList[pageId];

    Get.find<PopularProductsController>()
        .initProduct(product, Get.find<CartController>());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: Dimentions.foodDetailImageSize,
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(AppConstants.baseUrl +
                        AppConstants.uploadUrl +
                        product.img!)),
              ),
            ),
          ),
          Positioned(
            top: 45,
            left: Dimentions.width20,
            right: Dimentions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    if (page == 'cartPage') {
                      Get.toNamed(Approutes.getCartPage());
                    } else {
                      Get.toNamed(Approutes.initialRoute);
                    }
                  },
                  child: AppIcon(
                    icon: Icons.arrow_back_ios,
                  ),
                ),
                GetBuilder<PopularProductsController>(
                  builder: (productController) {
                    return GestureDetector(
                      onTap: () {
                        if (productController.totalItems >= 1) {
                          Get.toNamed(Approutes.getCartPage());
                        }
                      },
                      child: Stack(
                        children: [
                          AppIcon(icon: Icons.shopping_cart_outlined),
                          productController.totalItems >= 1
                              ? Positioned(
                                  right: 0,
                                  top: 0,
                                  child: AppIcon(
                                    icon: Icons.circle,
                                    size: 20,
                                    iconColor: Colors.transparent,
                                    backgroundColor: AppColors.mainColor,
                                  ),
                                )
                              : Container(),
                          Get.find<PopularProductsController>().totalItems >= 1
                              ? Positioned(
                                  right: 3,
                                  top: 3,
                                  child: BigText(
                                    text: Get.find<PopularProductsController>()
                                        .totalItems
                                        .toString(),
                                    size: 12,
                                    color: Colors.white,
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: Dimentions.foodDetailImageSize - 15,
            child: Container(
              padding: EdgeInsets.only(
                  left: Dimentions.width20,
                  right: Dimentions.width20,
                  top: Dimentions.height20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimentions.radius20),
                  topRight: Radius.circular(Dimentions.radius20),
                ),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppColumn(
                    text: product.name!,
                  ),
                  SizedBox(
                    height: Dimentions.height20,
                  ),
                  BigText(text: 'Introduce'),
                  SizedBox(
                    height: Dimentions.height20,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: ExpandableTextWidget(
                        text: product.description!,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductsController>(
        builder: (popularProductInstance) {
          return Container(
            height: Dimentions.bottomNavigationBarHeight,
            padding: EdgeInsets.only(
                top: Dimentions.height20, bottom: Dimentions.height20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: AppColors.buttonBackgroundColor),
            child: Row(
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
                      GestureDetector(
                        onTap: () {
                          popularProductInstance.setQuantity(true);
                        },
                        child: Icon(Icons.add),
                      ),
                      SizedBox(width: 5),
                      BigText(
                          text: popularProductInstance.inCartItems.toString()),
                      SizedBox(width: 5),
                      GestureDetector(
                        onTap: () {
                          popularProductInstance.setQuantity(false);
                        },
                        child: Icon(Icons.remove),
                      ),
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
                      popularProductInstance.addItems(product);
                    },
                    child: BigText(text: '\$ ${product.price} | Add to cart'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
