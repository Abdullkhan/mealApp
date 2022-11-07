import 'package:flutter/material.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/controllers/popular_products_controller.dart';
import 'package:food_delivery_app/controllers/recommended_products_controller.dart';
import 'package:food_delivery_app/routes/app_routes.dart';
import 'package:food_delivery_app/utilities/app_constants.dart';
import 'package:food_delivery_app/utilities/colors.dart';
import 'package:food_delivery_app/utilities/dimentions.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/expandable_text_widget.dart';
import 'package:get/get.dart';

class RecommendedFoodDetails extends StatelessWidget {
  final int pageId;
  final String page;
  RecommendedFoodDetails({
    required this.pageId,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    var recommendedProduct = Get.find<RecommendedProductsController>().recommendedProductList[pageId];
    Get.find<PopularProductsController>().initProduct(recommendedProduct, Get.find<CartController>());

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    if (page == 'cartPage') {
                      Get.toNamed(Approutes.getCartPage());
                    } else {
                      Get.toNamed(Approutes.getinitialRoute());
                    }
                  },
                  child: AppIcon(
                    icon: Icons.clear,
                  ),
                ),
                GetBuilder<PopularProductsController>(builder: (controller) {
                  return GestureDetector(
                    onTap: () {
                      if (controller.totalItems >= 1) {
                        Get.toNamed(Approutes.getCartPage());
                      }
                    },
                    child: Stack(
                      children: [
                        AppIcon(icon: Icons.shopping_cart_outlined),
                        Get.find<PopularProductsController>().totalItems >= 1
                            ? Positioned(
                                right: 0,
                                top: 0,
                                child: AppIcon(
                                  icon: Icons.circle,
                                  iconColor: Colors.transparent,
                                  backgroundColor: AppColors.mainColor,
                                  size: 20,
                                ),
                              )
                            : Container(),
                        Positioned(
                          right: 3,
                          top: 3,
                          child: BigText(
                            text: Get.find<PopularProductsController>().totalItems.toString(),
                            size: 12,
                            color: Colors.white,
                          ),
                        ),
                        Container(),
                      ],
                    ),
                  );
                }),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(30),
              child: Container(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                width: double.maxFinite,
                child: Center(child: BigText(text: recommendedProduct.name!)),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimentions.radius15),
                    topRight: Radius.circular(Dimentions.radius15),
                  ),
                ),
              ),
            ),
            backgroundColor: Colors.redAccent,
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                AppConstants.baseUrl + AppConstants.uploadUrl + recommendedProduct.img!,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    left: Dimentions.width10,
                    right: Dimentions.width10,
                  ),
                  child: ExpandableTextWidget(text: recommendedProduct.description!),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductsController>(builder: (popularProductInstance) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(
                  right: Dimentions.width20 * 2.5,
                  left: Dimentions.width20 * 2.5,
                  top: Dimentions.height20,
                  bottom: Dimentions.height20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      popularProductInstance.setQuantity(false);
                    },
                    child: AppIcon(
                      iconSize: Dimentions.iconSize24,
                      backgroundColor: AppColors.mainColor,
                      icon: Icons.remove,
                      iconColor: Colors.white,
                    ),
                  ),
                  BigText(text: '\$ ${recommendedProduct.price} X ${popularProductInstance.inCartItems} '),
                  GestureDetector(
                    onTap: () {
                      popularProductInstance.setQuantity(true);
                    },
                    child: AppIcon(
                      iconSize: Dimentions.iconSize24,
                      backgroundColor: AppColors.mainColor,
                      icon: Icons.add,
                      iconColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: Dimentions.bottomNavigationBarHeight,
              padding: EdgeInsets.only(top: Dimentions.height20, bottom: Dimentions.height20),
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
                    child: Icon(
                      Icons.favorite,
                      color: AppColors.mainColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      popularProductInstance.addItems(recommendedProduct);
                    },
                    child: Container(
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
                      child: BigText(text: '\$ ${recommendedProduct.price} & Add to cart'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
