import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tours_guide/ReUsable/Components/app_colors.dart';

class SignInInputTextField extends StatelessWidget {
  // final TextEditingController controller;
  // final FocusNode focusnode;
  // final FormFieldSetter onFieldSubmitedVlaue;
  // final FormFieldValidator formfieldValidator;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  // final String hint;
  final bool obsecure;
  // final bool enable, autoFocus;
  IconData icon;
  TextEditingController contr; FocusNode focNode;
  String labelText; String descrip;

  SignInInputTextField(
      {super.key,
        required this.contr,
        required this.descrip,
        required this.focNode,
        required this.labelText,
        required this.textInputAction,
        // required this.controller,
        // required this.focusnode,
        // required this.onFieldSubmitedVlaue,
        // required this.formfieldValidator,
        required this.keyboardType,
        // this.autoFocus = false,
        required this.obsecure,
        // this.enable = true,
        required this.icon,
        // required this.hint
        //
      });

  @override
  Widget build(BuildContext context)  {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w , vertical: 5.h),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        controller: contr,
        textInputAction: textInputAction,
        obscureText: obsecure,
        keyboardType: keyboardType,
        focusNode: focNode,
        validator: (value) {},
        onFieldSubmitted: (value) {},
        decoration: InputDecoration(

          // fillColor: Colors.grey.shade100,
          // filled: true,
          // hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          prefixIcon: Icon(icon , color: Colors.white,),
          hintText: descrip,
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.white),
          hintStyle: TextStyle(color:Colors.white),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),

        ),
      ),
    );
  }

}

class InputTextField extends StatelessWidget {
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final bool obsecure;
  IconData icon;
  TextEditingController contr;
  FocusNode? focNode;
   String descrip;

  InputTextField(
      {super.key,
        required this.contr,
        required this.descrip,
        this.focNode,
        required this.textInputAction,
        required this.keyboardType,
        required this.obsecure,
        required this.icon,
        //
      });

  @override
  Widget build(BuildContext context)  {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0 , vertical: 5),
      child: TextField(
        controller: contr,
        textInputAction: textInputAction,
        obscureText: obsecure,
        keyboardType: keyboardType,
        // focusNode: focNode,
        decoration: InputDecoration(
          prefixIcon: Icon(icon , color: AppColors.lightBgColor,),
          border: InputBorder.none,
          hintText: descrip,
        ),
      ),
    );
  }

}

class UpdateInputTextField extends StatelessWidget {
  // final TextEditingController controller;
  // final FocusNode focusnode;
  // final FormFieldSetter onFieldSubmitedVlaue;
  // final FormFieldValidator formfieldValidator;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  // final String hint;
  final bool obsecure;
  // final bool enable, autoFocus;
  IconData icon;
  Color filledColor;
  TextEditingController contr; FocusNode focNode;
  String labelText; String descrip;
  Color color;
  Color textColor;

  UpdateInputTextField(
      {super.key,
        required this.contr,
        required this.descrip,
        required this.focNode,
        required this.labelText,
        required this.textInputAction,
        required this.filledColor,
        required this.color,
        required this.textColor,
        // required this.controller,
        // required this.focusnode,
        // required this.onFieldSubmitedVlaue,
        // required this.formfieldValidator,
        required this.keyboardType,
        // this.autoFocus = false,
        required this.obsecure,
        // this.enable = true,
        required this.icon,
        // required this.hint
        //
      });

  @override
  Widget build(BuildContext context)  {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w , vertical: 5.h),
      child: TextFormField(
        controller: contr,
        textInputAction: textInputAction,
        obscureText: obsecure,
        keyboardType: keyboardType,
        focusNode: focNode,
        style: TextStyle(color: Colors.white),
        validator: (value) {},
        onFieldSubmitted: (value) {},
        decoration: InputDecoration(

          fillColor: filledColor,
          filled: true,
          // hintText: "Email",
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.iconsColor,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.iconsColor,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          prefixIcon: Icon(icon , color: AppColors.iconsColor,),
          hintText: descrip,
          hintStyle: TextStyle(color: textColor),
          labelText: labelText,
          labelStyle: TextStyle(color: color),
          // border: OutlineInputBorder(
          //   borderRadius: BorderRadius.only(
          //     topLeft: Radius.circular(30.r),
          //     bottomRight: Radius.circular(30.r),
          //     topRight: Radius.circular(30.r),
          //     bottomLeft: Radius.circular(30.r),
          //   ),
          // ),
        ),
      ),
    );
  }
// return Padding(
//   padding: const EdgeInsets.only(bottom: 8.0),
//   child: Container(
//     height: 54.h,
//     width: 280.w,
//     margin: EdgeInsets.only(bottom: 15.h),
//     decoration: BoxDecoration(
//       color: Colors.black12,
//       borderRadius: const BorderRadius.all(
//         Radius.circular(5),
//       ),
//       boxShadow: [
//         BoxShadow(
//           color: Colors.grey.withOpacity(0.3),
//           spreadRadius: 1,
//           blurRadius: 2,
//           offset: const Offset(0, 2),
//         ),
//       ],
//     ),
//     child: TextFormField(
//       controller: controller,
//       cursorColor: Colors.black12,
//       obscureText: obsecure,
//       keyboardType: keyboardType,
//       onFieldSubmitted: onFieldSubmitedVlaue,
//       style: Theme.of(context)
//           .textTheme
//           .bodyText2!
//           .copyWith(height: 0, fontSize: 19),
//       decoration: InputDecoration(
//         prefixIcon: Icon(icon),
//         hintText: hint,
//         enabled: enable,
//         contentPadding: EdgeInsets.all(15),
//         hintStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
//               height: 0,
//               color: Color(0xff242424).withOpacity(0.8),
//             ),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.all(
//             Radius.circular(8),
//           ),
//           borderSide: BorderSide(color: Colors.black12),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.all(
//             Radius.circular(8),
//           ),
//           borderSide: BorderSide(color: Colors.black12),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.all(
//             Radius.circular(8),
//           ),
//           borderSide: BorderSide(color: Colors.black12),
//         ),
//         errorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.all(
//             Radius.circular(8),
//           ),
//           borderSide: BorderSide(color: Colors.red),
//         ),
//       ),
//     ),
//   ),
// );

}


