import 'package:flutter/material.dart';
import 'package:food_delivery_app/controllers/popular_products_controller.dart';
import 'package:food_delivery_app/controllers/recommended_products_controller.dart';
import 'package:food_delivery_app/models/products_model.dart';
import 'package:food_delivery_app/routes/app_routes.dart';
import 'package:food_delivery_app/screens/food/food_details.dart';
import 'package:food_delivery_app/screens/food/recommended_food_details.dart';
import 'package:food_delivery_app/utilities/app_constants.dart';
import 'package:food_delivery_app/utilities/colors.dart';
import 'package:food_delivery_app/utilities/dimentions.dart';
import 'package:food_delivery_app/widgets/app_column.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/icon_and%20_text_widget.dart';
import 'package:food_delivery_app/widgets/small_text.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:get/get.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currentPageValue = 0.0;
  double scaleFactor = 0.8;
  double height = Dimentions.pageViewContainer;

  @override
  void initState() {
    super.initState();
    pageController.addListener(
      () {
        setState(() {
          _currentPageValue = pageController.page!;
        });
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  Widget _buildPageItem(int index, ProductsModel popularProduct) {
    Matrix4 matrix = Matrix4.identity();
    if (index == _currentPageValue.floor()) {
      var currentScale = 1 - (_currentPageValue - index) * (1 - scaleFactor);
      var currentTranfor = height * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTranfor, 0);
    } else if (index == _currentPageValue.floor() + 1) {
      var currentScale =
          scaleFactor + (_currentPageValue - index + 1) * (1 - scaleFactor);
      var currentTransfor = height * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1);
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTransfor, 0);
    } else if (index == _currentPageValue.floor() - 1) {
      var currentScale = 1 - (_currentPageValue - index) * (1 - scaleFactor);

      var currentTransfor = height * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1);
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTransfor, 0);
    } else {
      var currentScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, height * (1 - currentScale) / 2, 0);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(Approutes.getFoodDetails(index, 'home'));
            },
            child: Container(
              height: Dimentions.pageViewContainer,
              margin: EdgeInsets.only(
                  left: Dimentions.width10, right: Dimentions.width10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimentions.radius30),
                color: index.isEven ? Color(0XFF69c5df) : Colors.lightBlue,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    AppConstants.baseUrl +
                        AppConstants.uploadUrl +
                        popularProduct.img!,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimentions.pageViewTextContainer,
              margin: EdgeInsets.only(
                  left: Dimentions.width40,
                  right: Dimentions.width30,
                  bottom: Dimentions.height10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimentions.radius30),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF8e8e8e),
                    blurRadius: 5,
                    offset: Offset(0, 5),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(-5, 0),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(5, 0),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 15),
                child: Container(
                  child: AppColumn(
                    text: popularProduct.name!,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetBuilder<PopularProductsController>(
          builder: (popularProducts) {
            return popularProducts.isLoading
                ? Container(
                    height: Dimentions.mainContainer,
                    child: PageView.builder(
                      controller: pageController,
                      itemBuilder: (context, i) {
                        return _buildPageItem(
                            i, popularProducts.popularProductsList[i]);
                      },
                      itemCount: popularProducts.popularProductsList.length,
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(
                      color: AppColors.mainColor,
                    ),
                  );
          },
        ),
        GetBuilder<PopularProductsController>(
          builder: (popularProducts) {
            return DotsIndicator(
              dotsCount: popularProducts.popularProductsList.isEmpty
                  ? 1
                  : popularProducts.popularProductsList.length,
              position: _currentPageValue,
              decorator: DotsDecorator(
                size: Size.square(10),
                activeSize: Size(18, 8),
                activeColor: AppColors.mainColor,
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
              ),
            );
          },
        ),
        SizedBox(
          height: Dimentions.height40,
        ),
        Container(
          margin: EdgeInsets.only(left: Dimentions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: 'Recommended'),
              SizedBox(
                width: Dimentions.width10,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 5),
                child: BigText(text: '.', color: Colors.black38),
              ),
              SizedBox(
                width: Dimentions.width10,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 2),
                child: SmallText(text: 'Food Pairing'),
              )
            ],
          ),
        ),
        GetBuilder<RecommendedProductsController>(
          builder: (recommendedProduct) {
            return recommendedProduct.isLoading
                ? ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: recommendedProduct.recommendedProductList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(Approutes.getRecommendedFoodRoute(index, 'home'));
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              left: Dimentions.width10,
                              right: Dimentions.width10,
                              bottom: Dimentions.height10),
                          child: Row(
                            // image section
                            children: [
                              Container(
                                height: Dimentions.listViewImageSize,
                                width: Dimentions.listViewImageSize,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft:
                                        Radius.circular(Dimentions.radius20),
                                    bottomLeft:
                                        Radius.circular(Dimentions.radius20),
                                  ),
                                  color: Colors.white24,
                                  image: DecorationImage(
                                    image: NetworkImage(AppConstants.baseUrl +
                                        AppConstants.uploadUrl +
                                        recommendedProduct
                                            .recommendedProductList[index]
                                            .img!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: Dimentions.listViewTextContainer,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(
                                        Dimentions.radius20),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: Dimentions.width10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        BigText(
                                            text: recommendedProduct
                                                .recommendedProductList[index]
                                                .name!),
                                        SizedBox(
                                          height: Dimentions.height10,
                                        ),
                                        SmallText(
                                            text:
                                                'With chinese characteristics'),
                                        SizedBox(
                                          height: Dimentions.height10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            IconAndTextWidget(
                                                icon: Icons.circle_sharp,
                                                iconColor: AppColors.iconColor1,
                                                text: 'Normal'),
                                            IconAndTextWidget(
                                                icon: Icons.location_on,
                                                iconColor: AppColors.mainColor,
                                                text: '1.9 km'),
                                            IconAndTextWidget(
                                                icon: Icons.access_time_rounded,
                                                iconColor: AppColors.iconColor2,
                                                text: '20 mints'),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : Center(
                    child:
                        CircularProgressIndicator(color: AppColors.mainColor),
                  );
          },
        ),
      ],
    );
  }
}
