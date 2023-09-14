import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final Color color, textcolor, borderColor;
  final VoidCallback onPress;
  final bool loading;

  const RoundButton(
      {super.key,
      required this.title,
      required this.onPress,
      this.textcolor = Colors.white,
      this.borderColor = Colors.white,
      this.color = Colors.green,
      this.loading = false});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: onPress,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: InkWell(
            child: Container(
              height: 50.h,
              width: 300.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: AppColors.lightButtonColor,
              ),
              child: loading
                  ? Center(
                      child: CircularProgressIndicator(
                      color: Colors.white,
                    ))
                  : Center(
                      child: Text(
                        title,
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
