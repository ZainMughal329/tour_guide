// ignore_for_file: prefer_const_constructors, unused_field

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../ReUsable/Components/input_fields.dart';
import '../../../ReUsable/Components/round_button.dart';
import '../../../ReUsable/models/userModel.dart';
import '../../../ReUsable/routes/names.dart';
import 'controller.dart';

class SignUpView extends GetView<SignInController> {
  SignUpView({Key? key}) : super(key: key);

  final _formKwy = GlobalKey<FormState>();

  // Widget _buildLogo() {
  //   return Container(
  //     width: 110.w,
  //     margin: EdgeInsets.only(top: 84.w),
  //     child: Column(
  //       children: [
  //         Container(
  //           height: 76.w,
  //           width: 76.w,
  //           margin: EdgeInsets.symmetric(horizontal: 15.w),
  //           child: Stack(
  //             children: [
  //               Positioned(
  //                 child: Container(
  //                   child: Text("this is it"),
  //                   height: 76.w,
  //                   decoration: const BoxDecoration(
  //                     color: AppColors.primaryBackground,
  //                     boxShadow: [
  //                       Shadows.primaryShadow,
  //                     ],
  //                     borderRadius: BorderRadius.all(
  //                       Radius.circular(35),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               // Positioned(
  //               //   child: Image.asset('assets/images/ic_launcher.png'),
  //               // ),
  //             ],
  //           ),
  //         ),
  //         SizedBox(
  //           height: 5.w,
  //         ),
  //         const Text(
  //           'Let\'s chat',
  //           style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
  //         ),
  //       ],
  //     ),
  //   );
  // }
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
                  icon: Icons.person_outline,
                  controller: controller.userController,
                  focusnode: controller.userFocus,
                  onFieldSubmitedVlaue: (value) {},
                  formfieldValidator: (value) {},
                  keyboardType: TextInputType.emailAddress,
                  obsecure: false,
                  hint: 'UserName'),
            ),
            InputTextField(
                icon: Icons.email_outlined,
                controller: controller.emailController,
                focusnode: controller.emailFocus,
                onFieldSubmitedVlaue: (value) {},
                formfieldValidator: (value) {},
                keyboardType: TextInputType.emailAddress,
                obsecure: false,
                hint: 'Email'),
            InputTextField(
                icon: Icons.lock_open,
                controller: controller.passwordController,
                focusnode: controller.passwordFocus,
                onFieldSubmitedVlaue: (value) {},
                formfieldValidator: (value) {},
                keyboardType: TextInputType.emailAddress,
                obsecure: false,
                hint: 'Password'),
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
                Obx(
                  () => Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.h),
                    child: RoundButton(
                        title: 'SignUp',
                        loading: controller.state.loading.value,
                        onPress: () {
                          if (_formKwy.currentState!.validate()) {
                            // controller.registerUserWithEmailAndPassword(
                            //     controller.emailController.text.trim(),
                            //     controller.passwordController.text.trim());
                            var user = UserModel(
                              email: controller.emailController.text.trim(),
                              password:
                                  controller.passwordController.text.trim(),
                              phone: '+92**********',
                              userName: controller.userController.text.trim(),
                              photoUrl: '',
                            );
                            controller.storeUser(user, context);

                            // Get.offAllNamed(AppRoutes.Application);
                            // Get.toNamed(AppRoutes.Application);
                          }
                          // Utils().toastMsg('Clicked!!');
                        }),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
