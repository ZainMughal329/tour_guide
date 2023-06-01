import 'package:get/get.dart';
import 'package:flutter/material.dart';
class SnackBar{
  static void showSnackBar(String title,String message){
    Get.snackbar(
      title,
      message,
      colorText: Colors.black,
      snackPosition: SnackPosition.TOP,
      isDismissible: true,
      backgroundColor: Colors.white

    );
  }
}