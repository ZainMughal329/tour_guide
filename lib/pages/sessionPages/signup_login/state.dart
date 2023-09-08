import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignupLoginState {
  final loading = false.obs;
  final userSignUpLoading = false.obs;
  final companySignUpLoading = false.obs;
  final keyboardStatus = false.obs;

  var companyLogo = '';

  RxDouble strength = 0.0.obs;

  RxDouble companyPassStrength = 0.0.obs;


  final countryPicker = FlCountryCodePicker();

  Rx<CountryCode> code =
      CountryCode(name: 'Pakistan', code: 'PK', dialCode: '+92').obs;

  // controllers for login
  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();

  // controllers for signUp
  final signUpEmailController = TextEditingController();
  final signUpPasswordController = TextEditingController();
  final signUpPhoneController = TextEditingController();

  final signUpUserController = TextEditingController();

  // controllers for company signUp
  TextEditingController companyNameController = TextEditingController();
  TextEditingController companyEmailController = TextEditingController();
  TextEditingController companyPhoneNumberController = TextEditingController();
  TextEditingController companyDescController = TextEditingController();
  TextEditingController companyPassController = TextEditingController();

  // focus nodes for login
  final loginEmailFocus = FocusNode();
  final loginPasswordFocus = FocusNode();

  //focus nodes for signUp
  final signUpEmailFocus = FocusNode();
  final signUpPasswordFocus = FocusNode();
  final signUpUserFocus = FocusNode();

  // focus nodes for company

  FocusNode companyNameNode = FocusNode();

  FocusNode companyEmailNode = FocusNode();

  FocusNode companyPhoneNumberNode = FocusNode();

  FocusNode companyDescNode = FocusNode();

  FocusNode companyPassNode = FocusNode();
}
