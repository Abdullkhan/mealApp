import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/base/custom_loader.dart';
import 'package:food_delivery_app/base/custom_snackBar.dart';
import 'package:food_delivery_app/controllers/auth_controller.dart';
import 'package:food_delivery_app/routes/app_routes.dart';
import 'package:food_delivery_app/screens/auth/sign_up.dart';
import 'package:food_delivery_app/utilities/colors.dart';

import 'package:food_delivery_app/utilities/dimentions.dart';
import 'package:food_delivery_app/widgets/app_texfield.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:get/get.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _emailcontroller = TextEditingController();
    var _passwordcontroller = TextEditingController();

    void _login(AuthController authController) {
      var authController = Get.find<AuthController>();
      String email = _emailcontroller.text.trim();
      String password = _passwordcontroller.text.trim();

      if (email.isEmpty) {
        customSnackBar('Type in you email address', title: 'Email address');
      } else if (!GetUtils.isEmail(email)) {
        customSnackBar('Invalid email address', title: 'Email address');
      } else if (password.isEmpty) {
        customSnackBar('Type in you password', title: 'Password');
      } else if (password.length < 6) {
        customSnackBar('Password should be at least 6 digits', title: 'Password');
      } else {
        customSnackBar('All goes well', title: 'Successfull');

        authController.login(email, password).then((status) {
          if (status.isSuccess) {
            Get.toNamed(Approutes.getCartPage());
          } else {
            customSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(
        builder: (_authController) {
          return !_authController.isLoading
              ? SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(height: 60),
                      Container(
                        child: Center(
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 80,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(Dimentions.height10),
                              child: Image.asset('assets/images/foodlogo.png'),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: Dimentions.width20),
                        width: double.maxFinite,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hello',
                              style: TextStyle(fontSize: Dimentions.height20 * 3 + 10, fontWeight: FontWeight.bold),
                            ),
                            RichText(
                              text: TextSpan(
                                text: 'Sign into your account',
                                style: TextStyle(color: Colors.grey[500], fontSize: Dimentions.font20),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: Dimentions.height20),
                      AppTextField(textController: _emailcontroller, hintText: 'Email', icon: Icons.email),
                      SizedBox(height: Dimentions.height20),
                      AppTextField(
                        textController: _passwordcontroller,
                        hintText: 'Password',
                        icon: Icons.password,
                        isObscure: true,
                      ),
                      SizedBox(height: Dimentions.height20),
                      Row(
                        children: [
                          Expanded(child: Container()),
                          RichText(
                            text: TextSpan(
                              text: 'Sign into your account',
                              style: TextStyle(color: Colors.grey[500], fontSize: Dimentions.font20),
                            ),
                          ),
                          SizedBox(width: Dimentions.width20),
                        ],
                      ),
                      SizedBox(height: Dimentions.height40),
                      GestureDetector(
                        onTap: () {
                          _login(_authController);
                        },
                        child: Container(
                          width: Dimentions.width40 * 5,
                          height: Dimentions.height40 * 2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimentions.height40),
                            color: AppColors.mainColor,
                          ),
                          child: Center(
                            child: BigText(
                              text: 'Sign In',
                              color: Colors.white,
                              size: Dimentions.font30,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: Dimentions.height30),
                      RichText(
                        text: TextSpan(
                          recognizer: TapGestureRecognizer()..onTap = () => Get.back(),
                          text: 'Don\'t have an account?',
                          style: TextStyle(color: Colors.grey[500], fontSize: Dimentions.font20),
                          children: [
                            TextSpan(
                              recognizer: TapGestureRecognizer()..onTap = () => Get.to(() => SignUp()),
                              text: 'Create',
                              style: TextStyle(color: AppColors.mainBlackColor, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : CustomLoader();
        },
      ),
    );
  }
}
