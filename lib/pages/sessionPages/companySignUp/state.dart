import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompanySignUpState {
  final loading = false.obs;

  var companyLogo = '';

  TextEditingController nameController = TextEditingController();
  FocusNode nameNode = FocusNode();

  TextEditingController emailController = TextEditingController();
  FocusNode emailNode = FocusNode();

  TextEditingController phoneNumberController = TextEditingController();
  FocusNode phoneNumberNode = FocusNode();

  TextEditingController descController = TextEditingController();
  FocusNode descNode = FocusNode();

  TextEditingController passController = TextEditingController();
  FocusNode passNode = FocusNode();
}
