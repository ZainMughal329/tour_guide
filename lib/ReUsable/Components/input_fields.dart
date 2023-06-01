import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// import '../values/colors.dart';

class InputTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusnode;
  final FormFieldSetter onFieldSubmitedVlaue;
  final FormFieldValidator formfieldValidator;
  final TextInputType keyboardType;
  final String hint;
  final bool obsecure;
  final bool enable, autoFocus;
  const InputTextField(
      {super.key,
        required this.controller,
        required this.focusnode,
        required this.onFieldSubmitedVlaue,
        required this.formfieldValidator,
        required this.keyboardType,
        this.autoFocus = false,
        required this.obsecure,
        this.enable = true,
        required this.hint});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        height: 54.h,
        width: 280.w,
        // padding: EdgeInsets.all(10.w),
        margin: EdgeInsets.only(bottom: 15.h),
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: TextFormField(
          controller: controller,
          cursorColor: Colors.black12,
          // cursorHeight: 2.0,
          obscureText: obsecure,
          keyboardType: keyboardType,
          onFieldSubmitted: onFieldSubmitedVlaue,
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(height: 0, fontSize: 19),
          decoration: InputDecoration(

            hintText: hint,
            enabled: enable,
            contentPadding: EdgeInsets.all(15),
            hintStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
              height: 0,
              color: Color(0xff242424).withOpacity(0.8),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
              borderSide: BorderSide(color: Colors.black12),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
              borderSide: BorderSide(color: Colors.black12),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
              borderSide: BorderSide(color: Colors.black12),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
              borderSide: BorderSide(color: Colors.red),
            ),
          ),
        ),
      ),
    );
  }
}