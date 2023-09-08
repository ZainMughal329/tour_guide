import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tours_guide/ReUsable/Components/app_colors.dart';
import 'package:tours_guide/pages/sessionPages/signup_login/controller.dart';

import '../../../../ReUsable/Components/input_fields.dart';
import '../../../../ReUsable/Components/login_widget.dart';
import '../../../../ReUsable/models/userModel.dart';

class SignUpPage extends GetView<SignupLoginController> {
   SignUpPage({Key? key}) : super(key: key);

  final controller = Get.put<SignupLoginController>(SignupLoginController());

  Widget _buildForm(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 0, bottom: 0),
            child: TextFieldContainer(
              child: InputTextField(
                textInputAction: TextInputAction.next,
                obsecure: false,
                keyboardType: TextInputType.text,
                icon: Icons.person,
                contr: controller.state.signUpUserController,
                descrip: 'Enter UserName',
                // focNode: controller.emailFocus,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.0, bottom: 4),
            child: TextFieldContainer(
              child: InputTextField(
                textInputAction: TextInputAction.next,
                obsecure: false,
                keyboardType: TextInputType.emailAddress,
                icon: Icons.email_outlined,
                contr: controller.state.signUpEmailController,
                descrip: 'Enter your email',
                // focNode: controller.emailFocus,
              ),
            ),
          ),
          Obx(
            () => LoginWidget(
              controller.state.code.value,
              () async {
                final code = await controller.state.countryPicker
                    .showPicker(context: context);
                // Null check
                if (code != null) {
                  controller.state.code.value = code;
                }
                ;
              },
              controller.state.signUpPhoneController,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: TextFieldContainer(
              child: InputTextField(
                obsecure: true,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                icon: Icons.lock_open,
                contr: controller.state.signUpPasswordController,
                descrip: 'Enter your password',
                onChange: (val) {
                  controller.validatePasswordStrength(val);
                },
                // focNode: controller.passwordFocus,
              ),
            ),
          ),
          SizedBox(height: 10),
          Obx(
            () {
              return Text(
                'Password Strength: ${controller.passwordStrengthLabel()}',
                style: TextStyle(
                  color: controller.state.strength.value < 0.3
                      ? Colors.red
                      : Colors.green,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding:  EdgeInsets.only(bottom: 200.h),
        child: Column(
          children: [
            _buildForm(context),
            const SizedBox(height: 10),
            Obx((){
              return Hero(
                tag: "signUp_btn",
                child: GestureDetector(
                  onTap: () {
                    if (controller.formIsValid()) {
                      // Form is valid, proceed with registration
                      var user = UserModel(
                        email: controller.state.signUpEmailController.text.trim(),
                        password:
                        controller.state.signUpPasswordController.text.trim(),
                        phone: controller.state.code.value.dialCode +
                            controller.state.signUpPhoneController.text
                                .trim()
                                .toString(),
                        userName: controller.state.signUpUserController.text.trim(),
                        photoUrl: '',
                        location: '',
                        fcmToken: '',
                        addTime: Timestamp.now(),
                      );
                      controller.storeUser(
                        user,
                        context,
                        controller.state.signUpEmailController.text.trim(),
                        controller.state.signUpPasswordController.text.trim(),
                      );
                    } else {
                      Get.snackbar('Error', 'All fields must be filled');
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppColors.lightButtonColor,
                      borderRadius: BorderRadius.circular(29),
                    ),
                    child: Center(
                      child: controller.state.userSignUpLoading == true ? Center(child: CircularProgressIndicator(color: Colors.white),) :
                      Text(
                        "Sign Up".toUpperCase(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              );
            }),
            const SizedBox(height: AppColors.defaultPadding),
          ],
        ),
      ),
    );
  }
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
