import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tours_guide/ReUsable/Components/app_colors.dart';

class Snackbar {
  static void showSnackBar(String title, String message) {
    Get.snackbar(title, message,
        colorText: Colors.black,
        snackPosition: SnackPosition.TOP,
        isDismissible: true,
        backgroundColor: AppColors.lightCardColor.withOpacity(0.2));
  }
}
