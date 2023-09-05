import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingState {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  RxString personString = "Select number of persons".obs;
  RxString monthString = "Select month".obs;

  String? uid;
  String? companyName;
  String? companyId;
  String? tourTitle;
  String? pricePerPerson;
  String? tourImgae;

}