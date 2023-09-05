import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:tours_guide/ReUsable/Components/app_colors.dart';
import 'package:tours_guide/pages/sessionPages/signup_login/controller.dart';

import '../../../../ReUsable/Components/input_fields.dart';
import '../../../../ReUsable/Components/login_widget.dart';
import '../../../../ReUsable/models/companyModel.dart';
import '../../../../ReUsable/routes/names.dart';

class CompanySignUp extends GetView<SignupLoginController> {
  CompanySignUp({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();

  Widget _buildForm(BuildContext context) {
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
                icon: Icons.house,
                contr: controller.state.companyNameController,
                descrip: 'Enter company name',
                // focNode: controller.state.loginEmailFocus,
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
                contr: controller.state.companyEmailController,
                descrip: 'Enter company email',
                // focNode: controller.state.loginEmailFocus,
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
              controller.state.companyPhoneNumberController,
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.only(top: 8.0, bottom: 4),
          //   child: TextFieldContainer(
          //     child: InputTextField(
          //       textInputAction: TextInputAction.next,
          //       obsecure: false,
          //       keyboardType: TextInputType.phone,
          //       icon: Icons.phone,
          //       contr: controller.state.companyPhoneNumberController,
          //       descrip: 'Enter company phoneNo.',
          //       // focNode: controller.state.loginEmailFocus,
          //     ),
          //   ),
          // ),
          Padding(
            padding: EdgeInsets.only(top: 8.0, bottom: 4),
            child: TextFieldContainer(
              child: InputTextField(
                textInputAction: TextInputAction.next,
                obsecure: false,
                keyboardType: TextInputType.text,
                icon: Icons.note,
                contr: controller.state.companyDescController,
                descrip: 'Enter company description',
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
                icon: Icons.lock_open,
                contr: controller.state.companyPassController,
                descrip: 'Enter password',

                onChange: (val) {
                  controller.validateCompanyPasswordStrength(val);
                },
                // focNode: controller.state.loginPasswordFocus,
              ),
            ),
          ),
          SizedBox(height: 10),
          Obx(
            () {
              return Text(
                'Password Strength: ${controller.passwordCompanyStrengthLabel()}',
                style: TextStyle(
                  color: controller.state.companyPassStrength.value < 0.3
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
      child: Container(
        child: Column(
          children: [
            _buildForm(context),
            const SizedBox(height: AppColors.defaultPadding),
            Hero(
              tag: "company_signUp_btn",
              child: GestureDetector(
                onTap: () {
                  final CompanyUser = CompanyModel(
                    companyEmail: controller.state.companyEmailController.text
                        .trim()
                        .toString(),
                    companyName: controller.state.companyNameController.text
                        .trim()
                        .toString(),
                    status: 'false',
                    companyPhone: controller.state.code.value.dialCode +
                        controller.state.companyPhoneNumberController.text
                            .trim()
                            .toString(),
                    companyDescription: controller
                        .state.companyDescController.text
                        .trim()
                        .toString(),
                    pass: controller.state.companyPassController.text
                        .trim()
                        .toString(),
                    logo: '',
                    location: '',
                    fcmToken: '',
                    addTime: Timestamp.now(),
                  );
                  controller.storeCompany(CompanyUser, context);
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
