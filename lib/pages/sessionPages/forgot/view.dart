
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:air_proj_comp/common/utils/snackBar.dart'
import 'package:get/get.dart';

import '../../../ReUsable/Components/round_button.dart';
import 'controller.dart';

class ForgotPasswordView extends GetView<ForgotPassController> {
   ForgotPasswordView({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final emailFocusNode = FocusNode();
  void dispose(){
    emailController.dispose();
    emailFocusNode.dispose();
  }


  Widget _buildLogo() {
    return Container(
        child: Image(
          image: AssetImage('assets/images/forgot.jpg'),
        ));

  }

  Widget _buildForm(){
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 15.0.h),
      child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Padding(
              //   padding:  EdgeInsets.symmetric(vertical : 4.0.h),
              //   child: InputTextField(
              //     autoFocus: true,
              //       enable: true,
              //
              //       controller: emailController,
              //       focusnode: emailFocusNode,
              //       onFieldSubmitedVlaue: (value) {
              //         // Utils().focusChange(
              //         //     context, userFocus, emailFocus);
              //       },
              //       formfieldValidator: (value) {
              //         return null;
              //       },
              //       keyboardType: TextInputType.emailAddress,
              //       obsecure: false,
              //       hint: 'Email'),
              // ),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 30.w,vertical: 20.h),
                child: TextFormField(
                  controller: emailController,
                  focusNode: emailFocusNode,
                  onFieldSubmitted: (value){

                  },
                  validator: (value){

                  },
                  keyboardType: TextInputType.emailAddress,
                  obscureText: false,
                  decoration: InputDecoration(
                    hintText: "Enter Email",
                    prefixIcon: Icon(Icons.email_outlined),
                    labelText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),

                    )
                  ),
                ),
              )

            ],
          )),
    );
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 8.0.w,vertical: 4.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              _buildLogo(),
                Padding(
                  padding:  EdgeInsets.symmetric(vertical: 20.0.h),
                  child: Text(

                    "Recieve an Email to Reset\n your Password",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 28.sp),
                    textAlign: TextAlign.center,

                  ),
                ),
                _buildForm(),


                Obx((){
                  return controller.state.loading.value == true ?
                      CircularProgressIndicator(
                        color: Colors.green,
                      ) :
                  RoundButton(
                      loading: controller.state.loading.value,
                      title: "Send Mail",
                      onPress: (){
                        if(_formKey.currentState!.validate()){
                          // controller.sendResetMail(emailController.text.trim().toString());
                        }else{
                          print('Error in email');
                        }

                      });
                })

              ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
