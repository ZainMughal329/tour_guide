import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompanySignUpState {
  // var index = 0.obs;
  final loading = false.obs;

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