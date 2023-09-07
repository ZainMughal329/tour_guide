import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PersonState {
  final loading = false.obs;
  var to_uid = ''.obs;
  var to_name = ''.obs;
  var to_avatar = ''.obs;
  var to_location = ''.obs;
  RxString name = 'John Doe'.obs;
  RxString email = 'email@gmail.com'.obs;
  RxBool isDarkMode = false.obs;

  RxString cardNumber = ''.obs;
  RxString expiryDate = ''.obs;
  RxString cardHolderName = ''.obs;
  RxString cvvCode = ''.obs;
  RxBool isCvvFocused = false.obs;
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;
  OutlineInputBorder? border;
}
