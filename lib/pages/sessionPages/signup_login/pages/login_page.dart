import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:tours_guide/ReUsable/Components/app_colors.dart';
import 'package:tours_guide/pages/sessionPages/signup_login/controller.dart';

import '../../../../ReUsable/Components/input_fields.dart';
import '../../../../ReUsable/Components/top_image.dart';
import '../../../../ReUsable/routes/names.dart';

class LoginPage extends GetView<SignupLoginController> {
  LoginPage({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // TopImage(),

        _buildForm(controller.state.loginEmailController , controller.state.loginPasswordController),
        const SizedBox(height: AppColors.defaultPadding),
        Hero(
          tag: "login_btn",
          child: GestureDetector(
            onTap: () {
              // if (formKey.currentState!.validate()) {
                if (controller.state.loginEmailController.text ==
                    'admin@admin.com' &&
                    controller.state.loginPasswordController
                        .text ==
                        'admin@123') {
                  Get.offAndToNamed(AppRoutes.Admin)!
                      .then((value) {
                    controller.state.loginEmailController
                        .clear();
                    controller.state.loginPasswordController
                        .clear();
                  });
                } else {
                  controller
                      .loginUserWithEmailAndPassword(
                    controller.state.loginEmailController.text
                        .trim(),
                    controller.state.loginPasswordController.text
                        .trim(),
                  );
                }
              // }
            },
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.lightButtonColor,
                borderRadius: BorderRadius.circular(29),
              ),
              child: Center(
                child: Text(
                  "Login".toUpperCase(),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: AppColors.defaultPadding),
      ],
    );
  }
}

Widget _buildForm(
    TextEditingController email ,TextEditingController pass
    ) {
  return Form(
    // key: formKey,
    child: Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 8.0, bottom: 4),
          child: TextFieldContainer(
            child: InputTextField(
              textInputAction: TextInputAction.next,
              obsecure: false,
              keyboardType: TextInputType.emailAddress,
              icon: Icons.email_outlined,
              contr: email,
              descrip: 'Enter your email',
              // focNode: controller.state.loginEmailFocus,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 8.0),
          child: TextFieldContainer(
            child: InputTextField(
              obsecure: true,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.emailAddress,
              icon: Icons.lock_open ,
              contr: pass,
              descrip: 'Enter your password',
              // focNode: controller.state.loginPasswordFocus,
            ),
          ),
        ),
      ],
    ),
  );
}
class TextFieldContainer extends StatelessWidget {
  final Widget child;

  const TextFieldContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size * 0.8;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width,
      decoration: BoxDecoration(
        color: AppColors.lightTextFormFieldColor,
        borderRadius: BorderRadius.circular(29),
      ),
      child: child,
    );
  }
}
