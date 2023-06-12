import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tours_guide/ReUsable/Components/app_colors.dart';
import 'package:tours_guide/pages/sessionPages/sigin/pick_profile_image.dart';

import '../../../ReUsable/Components/input_fields.dart';
import '../../../ReUsable/Components/round_button.dart';
import '../../../ReUsable/models/userModel.dart';
import '../../../ReUsable/routes/names.dart';
import 'controller.dart';

class SignUpView extends GetView<SignInController> {
  SignUpView({Key? key}) : super(key: key);

  final _formKwy = GlobalKey<FormState>();

  Widget _buildLogo() {
    return Container(
        child: Image(
      image: AssetImage('assets/images/signUp.jpg'),
    ));
  }

  Widget _signUpForm() {
    return Form(
        key: _formKwy,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0.h),
              child: InputTextField(
                  obsecure: false,
                  keyboardType: TextInputType.text,
                  icon: Icons.person_outline,
                  contr: controller.userController,
                  descrip: 'Enter your username',
                  focNode: controller.userFocus,
                  labelText: 'UserName'),
            ),
            InputTextField(
                obsecure: false,
                keyboardType: TextInputType.emailAddress,
                icon: Icons.email_outlined,
                contr: controller.emailController,
                descrip: 'Enter your email',
                focNode: controller.emailFocus,
                labelText: 'Email'),
            InputTextField(
                obsecure: true,
                keyboardType: TextInputType.visiblePassword,
                icon: Icons.lock_open,
                contr: controller.passwordController,
                descrip: 'Enter your password',
                focNode: controller.passwordFocus,
                labelText: 'Password'),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.015),
                _buildLogo(),
                SizedBox(
                  height: height * 0.05,
                ),
                _signUpForm(),
                // Obx(
                //   () => Padding(
                //     padding: EdgeInsets.symmetric(vertical: 15.h),
                //     child: RoundButton(
                //       title: 'SignUp',
                //       loading: controller.state.loading.value,
                //       onPress: () {
                //         if (_formKwy.currentState!.validate()) {
                //           var user = UserModel(
                //             email: controller.emailController.text
                //                 .trim()
                //                 .toString(),
                //             password: controller.passwordController.text
                //                 .trim()
                //                 .toString(),
                //             phone: '+92**********',
                //             userName: controller.userController.text
                //                 .trim()
                //                 .toString(),
                //             photoUrl: '',
                //           );
                //           controller.storeUser(user, context);
                //         }
                //       },
                //     ),
                //   ),
                // ),
                SizedBox(height: 20.h),
                // RoundButton(
                //     title: 'Next',
                //     onPress: () {
                //       Get.to(
                //         () => PickProfileImage(
                //             email: controller.emailController.text,
                //             pass: controller.passwordController.text,
                //             name: controller.userController.text,
                //             phone: '+92-xxxxxxx'),
                //       );
                //     }),
                Obx(
                      () => Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.h),
                    child: RoundButton(
                      title: 'SignUp',
                      loading: controller.state.loading.value,
                      onPress: () {
                        var user = UserModel(
                          email: controller.emailController.text.trim().toString(),
                          password:
                          controller.passwordController.text.trim().toString(),
                          phone: '+92**********',
                          userName: controller.userController.text.trim().toString(),
                          photoUrl: '',
                        );
                        controller.storeUser(user, context);
                      },
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.offAllNamed(AppRoutes.SIGN_IN);
                  },
                  child: Text.rich(
                    TextSpan(
                      text: 'Already have an accont?',
                      style: Theme.of(context).textTheme.bodyMedium,
                      children: [
                        TextSpan(
                            text: 'Login',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(decoration: TextDecoration.underline))
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 100.w, vertical: 5.h),
                  child: Divider(
                    color: AppColors.iconColor,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 30.h),
                  child: TextButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.Company_SignUp);
                    },
                    child: Text(
                      'Click to \n Sign up as a Tour Company',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppColors.textButtonColor,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
