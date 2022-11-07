import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_delivery_app/utilities/colors.dart';
import 'package:food_delivery_app/utilities/dimentions.dart';
import 'package:food_delivery_app/widgets/account_widget.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/big_text.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.mainColor,
        title: Center(
          child: BigText(
            text: 'Profile',
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(top: Dimentions.height20),
        child: Column(
          children: [
            AppIcon(
              icon: Icons.person,
              iconColor: Colors.white,
              backgroundColor: AppColors.mainColor,
              size: MediaQuery.of(context).size.height * 0.17,
              iconSize: MediaQuery.of(context).size.height * 0.08,
            ),
            SizedBox(
              height: Dimentions.height30,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    AccountWidget(
                      appIcon: AppIcon(
                        icon: Icons.person,
                        backgroundColor: AppColors.mainColor,
                        iconColor: Colors.white,
                        size: Dimentions.height10 * 5,
                        iconSize: Dimentions.height10 + 15,
                      ),
                      bigText: BigText(
                        text: 'Ahmed',
                      ),
                    ),
                    SizedBox(height: Dimentions.height20),
                    AccountWidget(
                      appIcon: AppIcon(
                        icon: Icons.phone,
                        backgroundColor: Colors.green,
                        iconColor: Colors.white,
                        size: Dimentions.height10 * 5,
                        iconSize: Dimentions.height10 + 15,
                      ),
                      bigText: BigText(
                        text: '0336063',
                      ),
                    ),
                    SizedBox(height: Dimentions.height20),
                    AccountWidget(
                      appIcon: AppIcon(
                        icon: Icons.email,
                        backgroundColor: Colors.yellow,
                        iconColor: Colors.white,
                        size: Dimentions.height10 * 5,
                        iconSize: Dimentions.height10 + 15,
                      ),
                      bigText: BigText(
                        text: 'ab@gmail.com',
                      ),
                    ),
                    SizedBox(height: Dimentions.height20),
                    AccountWidget(
                      appIcon: AppIcon(
                        icon: Icons.location_on,
                        backgroundColor: Colors.lightBlue,
                        iconColor: Colors.white,
                        size: Dimentions.height10 * 5,
                        iconSize: Dimentions.height10 + 15,
                      ),
                      bigText: BigText(
                        text: 'Fill in the address',
                      ),
                    ),
                    SizedBox(height: Dimentions.height20),
                    AccountWidget(
                      appIcon: AppIcon(
                        icon: Icons.message,
                        backgroundColor: Colors.pinkAccent,
                        iconColor: Colors.white,
                        size: Dimentions.height10 * 5,
                        iconSize: Dimentions.height10 + 15,
                      ),
                      bigText: BigText(
                        text: 'Ahmed',
                      ),
                    ),
                    SizedBox(height: Dimentions.height20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
