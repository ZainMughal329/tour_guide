import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingState {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  RxString personString = "Select number of persons".obs;
  RxString monthString = "Select month".obs;

}