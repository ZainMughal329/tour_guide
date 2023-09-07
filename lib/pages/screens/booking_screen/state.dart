import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingState {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  RxString personString = "Select number of persons".obs;
  RxString monthString = "Select month".obs;
  RxBool loading = false.obs;

  String? uid;
  String? companyName;
  String? companyId;
  String? tourTitle;
  String? pricePerPerson;
  String? tourImgae;



  RxString cardNumber = ''.obs;
  RxString expiryDate = ''.obs;
  RxString cardHolderName = ''.obs;
  RxString cvvCode = ''.obs;
  RxBool isCvvFocused = false.obs;
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;
  OutlineInputBorder? border;

}