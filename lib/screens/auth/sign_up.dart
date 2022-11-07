import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/base/custom_loader.dart';
import 'package:food_delivery_app/base/custom_snackBar.dart';
import 'package:food_delivery_app/controllers/auth_controller.dart';
import 'package:food_delivery_app/models/signup_body_model.dart';
import 'package:food_delivery_app/utilities/colors.dart';

import 'package:food_delivery_app/utilities/dimentions.dart';
import 'package:food_delivery_app/widgets/app_texfield.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:get/get.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _emailcontroller = TextEditingController();
    var _passwordcontroller = TextEditingController();
    var _namecontroller = TextEditingController();
    var _phonecontroller = TextEditingController();
    var signUpImages = [
      'twitter.png',
      'facebook.png',
      'google.png',
    ];
    void _registration() {
      var authController = Get.find<AuthController>();
      String email = _emailcontroller.text.trim();
      String password = _passwordcontroller.text.trim();
      String name = _namecontroller.text.trim();
      String phoneNumber = _phonecontroller.text.trim();

      if (email.isEmpty) {
        customSnackBar(
          'Type in you email address',
          title: 'Email address',
        );
      } else if (!GetUtils.isEmail(email)) {
        customSnackBar('Invalid email address', title: 'Email address');
      } else if (password.isEmpty) {
        customSnackBar('Type in you password', title: 'Password');
      } else if (password.length < 6) {
        customSnackBar('Password should be at least 6 digits', title: 'Password');
      } else if (name.isEmpty) {
        customSnackBar('Type in your name', title: 'Name');
      } else if (phoneNumber.isEmpty) {
        customSnackBar('Type in your phone number', title: 'Phone');
      } else {
        customSnackBar('All goes well', title: 'Successfull');
        SignUpBody signUpBody = SignUpBody(email: email, password: password, name: name, phone: phoneNumber);
        print(signUpBody.toString());
        authController.registration(signUpBody).then((status) {
          if (status.isSuccess) {
            print('Successfully register');
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
                      AppTextField(
                          textController: _emailcontroller,
                          hintText: 'Email',
                          icon: Icons.email,
                          keyboardType: TextInputType.emailAddress),
                      SizedBox(height: Dimentions.height20),
                      AppTextField(
                        isObscure: true,
                        textController: _passwordcontroller,
                        hintText: 'Password',
                        icon: Icons.password,
                        keyboardType: TextInputType.visiblePassword,
                      ),
                      SizedBox(height: Dimentions.height20),
                      AppTextField(
                          textController: _namecontroller,
                          hintText: 'Name',
                          icon: Icons.person,
                          keyboardType: TextInputType.name),
                      SizedBox(height: Dimentions.height20),
                      AppTextField(
                        textController: _phonecontroller,
                        hintText: 'phone',
                        icon: Icons.phone,
                        keyboardType: TextInputType.phone,
                      ),
                      SizedBox(height: Dimentions.height30),
                      GestureDetector(
                        onTap: () {
                          _registration();
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
                              text: 'Sign Up',
                              color: Colors.white,
                              size: Dimentions.font30,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: Dimentions.height10),
                      RichText(
                        text: TextSpan(
                          recognizer: TapGestureRecognizer()..onTap = () => Get.back(),
                          text: 'Have an account already?',
                          style: TextStyle(color: Colors.grey[500], fontSize: Dimentions.font20),
                        ),
                      ),
                      SizedBox(height: Dimentions.height40),
                      RichText(
                        text: TextSpan(
                          text: 'Use one of the following methods',
                          style: TextStyle(color: Colors.grey[500], fontSize: Dimentions.font16),
                        ),
                      ),
                      SizedBox(height: Dimentions.height10),
                      Wrap(
                        children: List.generate(
                          3,
                          (index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: Dimentions.height30,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(Dimentions.height10),
                                child: Image.asset('assets/images/' + signUpImages[index]),
                              ),
                            ),
                          ),
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
