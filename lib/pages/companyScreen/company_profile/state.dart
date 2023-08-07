import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CompanyProfileState {
  FocusNode nameNode = FocusNode();
  final loading = false.obs;

  FocusNode emailNode = FocusNode();

  FocusNode phoneNumberNode = FocusNode();

  FocusNode descNode = FocusNode();

  FocusNode passNode = FocusNode();
}
