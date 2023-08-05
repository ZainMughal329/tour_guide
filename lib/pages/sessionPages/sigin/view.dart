import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tours_guide/ReUsable/Components/input_fields.dart';
import 'package:tours_guide/pages/sessionPages/sigin/sign_up_view.dart';

import '../../../ReUsable/Components/round_button.dart';
import '../../../ReUsable/routes/names.dart';
import 'controller.dart';

class SignInPage extends GetView<SignInController> {
  SignInPage({Key? key}) : super(key: key);
  final _formKwy = GlobalKey<FormState>();

  Widget _buildLogo() {
    return Container(
        child: Image(
      image: AssetImage('assets/images/loggin.jpg'),
    ));
  }

  Widget _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: Text(
        'Log In',
        style: TextStyle(color: Colors.black, fontSize: 30.sp),
      ),
      backgroundColor: Colors.white,
      elevation: 0.3,
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKwy,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 8.0.h, bottom: 4.h),
            child: InputTextField(
                textInputAction: TextInputAction.next,
                obsecure: false,
                keyboardType: TextInputType.emailAddress,
                icon: Icons.email_outlined,
                contr: controller.emailController,
                descrip: 'Enter your email',
                focNode: controller.emailFocus,
                labelText: 'Email'),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 8.0.h),
            child: InputTextField(
                obsecure: true,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.emailAddress,
                icon: Icons.lock_open,
                contr: controller.passwordController,
                descrip: 'Enter your password',
                focNode: controller.passwordFocus,
                labelText: 'Password'),
          ),
        ],
      ),
    );
  }

  Widget _buildThirdPartyServices(String loginType, String logo) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 54.h,
        width: 280.w,
        padding: EdgeInsets.all(10.w),
        margin: EdgeInsets.only(bottom: 15.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment:
              logo == '' ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            logo == ''
                ? Container()
                : Container(
                    padding: EdgeInsets.only(left: 44.w, right: 30.w),
                    child: Image.asset('assets/icons/$logo.png'),
                  ),
            Text(
              'Sign in with $loginType',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14.sp,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/login.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        // body: SingleChildScrollView(
        //   child: Center(
        //     child: Padding(
        //       padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        //       child: Column(
        //         children: [
        //           // _buildAppBar(),
        //           // _buildLogo(),
        //           _buildForm(),
        //           InkWell(
        //             onTap: () {
        //               Get.toNamed(AppRoutes.Forgot_Password);
        //             },
        //             child: Container(
        //               padding: EdgeInsets.only(right: 20.w),
        //               child: Align(
        //                 alignment: Alignment.centerRight,
        //                 child: Text(
        //                   'Forgot Password?',
        //                   style: Theme.of(context)
        //                       .textTheme
        //                       .bodyMedium!
        //                       .copyWith(decoration: TextDecoration.underline),
        //                 ),
        //               ),
        //             ),
        //           ),
        //           Padding(
        //             padding: EdgeInsets.symmetric(vertical: 20.h),
        //             child: Obx(
        //               () {
        //                 return RoundButton(
        //                   title: 'LogIn',
        //                   loading: controller.state.loading.value,
        //                   onPress: () {
        //                     if (_formKwy.currentState!.validate()) {
        //                       if (controller.emailController.text ==
        //                               'admin@admin.com' &&
        //                           controller.passwordController.text ==
        //                               'admin@123') {
        //                         Get.offAndToNamed(AppRoutes.Admin);
        //                       } else {
        //                         controller.loginUserWithEmailAndPassword(
        //                           controller.emailController.text.trim(),
        //                           controller.passwordController.text.trim(),
        //                         );
        //                       }
        //                     }
        //                   },
        //                 );
        //               },
        //             ),
        //           ),
        //           _buildThirdPartyServices('Google', 'google'),
        //           SizedBox(height: 15.h),
        //           InkWell(
        //             onTap: () {
        //               Get.toNamed(AppRoutes.SIGN_UP);
        //             },
        //             child: Text.rich(
        //               TextSpan(
        //                 text: 'Don\'t have an account?',
        //                 style: Theme.of(context).textTheme.bodyMedium,
        //                 children: [
        //                   TextSpan(
        //                     text: 'Sign Up',
        //                     style: Theme.of(context)
        //                         .textTheme
        //                         .bodyMedium!
        //                         .copyWith(decoration: TextDecoration.underline),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
        body: Stack(
          children: [
            Container(),
            Container(
              padding: EdgeInsets.only(left: 35, top: 130),
              child: Text(
                'Welcome\nBack',
                style: TextStyle(color: Colors.white, fontSize: 33),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 35, right: 35),
                      child: Column(
                        children: [
                          _buildForm(),
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Sign in',
                                style: TextStyle(
                                    fontSize: 27, fontWeight: FontWeight.w700),
                              ),
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Color(0xff4c505b),
                                child: IconButton(
                                    color: Colors.white,
                                    onPressed: () {
                                      if (_formKwy.currentState!.validate()) {
                                        if (controller.emailController.text ==
                                                'admin@admin.com' &&
                                            controller
                                                    .passwordController.text ==
                                                'admin@123') {
                                          Get.offAndToNamed(AppRoutes.Admin)!.then((value) {
                                            controller.emailController.clear();
                                            controller.passwordController.clear();
                                          });
                                        } else {
                                          controller
                                              .loginUserWithEmailAndPassword(
                                            controller.emailController.text
                                                .trim(),
                                            controller.passwordController.text
                                                .trim(),
                                          );
                                        }
                                      }
                                    },
                                    icon: Icon(
                                      Icons.arrow_forward,
                                    )),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Get.to( () =>SignUpView());
                                },
                                child: Text(
                                  'Sign Up',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Color(0xff4c505b),
                                      fontSize: 18),
                                ),
                                style: ButtonStyle(),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Get.toNamed(AppRoutes.Forgot_Password);
                                  },
                                  child: Text(
                                    'Forgot Password',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Color(0xff4c505b),
                                      fontSize: 18,
                                    ),
                                  )),
                            ],
                          )
                        ],
                      ),
                    )
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
