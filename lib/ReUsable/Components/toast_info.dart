import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tours_guide/ReUsable/Components/app_colors.dart';

Future<void> toastInfo({
  required String msg,
  var length=Toast.LENGTH_LONG,
  Color backgroundColor = Colors.black,
  Color textColor = Colors.white,
}) {
  return Fluttertoast.showToast(
    msg: msg,
    toastLength: length,
    gravity: ToastGravity.TOP,
    timeInSecForIosWeb: 2,
    backgroundColor: AppColors.lightCardColor.withOpacity(0.2),
    textColor: backgroundColor,
    fontSize: 16.sp,
  );
}
