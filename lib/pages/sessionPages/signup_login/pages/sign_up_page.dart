import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tours_guide/ReUsable/Components/app_colors.dart';
import 'package:tours_guide/pages/sessionPages/signup_login/controller.dart';

import '../../../../ReUsable/Components/input_fields.dart';
import '../../../../ReUsable/models/userModel.dart';

class SignUpPage extends GetView<SignupLoginController> {
  const SignUpPage({Key? key}) : super(key: key);

  Widget _buildForm() {
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
                // focNode: controller.passwordFocus,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildForm(),
          const SizedBox(height: 10),
          Hero(
            tag: "signUp_btn",
            child: GestureDetector(
              onTap: () {
                var user = UserModel(
                  email: controller.state.signUpEmailController.text
                      .trim()
                      .toString(),
                  password: controller.state.signUpPasswordController.text
                      .trim()
                      .toString(),
                  phone: '+92**********',
                  userName: controller.state.signUpUserController.text
                      .trim()
                      .toString(),
                  photoUrl: '',
                  location: '',
                  fcmToken: '',
                  addTime: Timestamp.now(),
                );
                controller.storeUser(
                  user,
                  context,
                  controller.state.signUpEmailController.text.trim().toString(),
                  controller.state.signUpPasswordController.text
                      .trim()
                      .toString(),
                );
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
                    "SignUp".toUpperCase(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: AppColors.defaultPadding),
        ],
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
