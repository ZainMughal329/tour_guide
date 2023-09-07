import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tours_guide/pages/screens/PersonPage/controller.dart';

class ContactUsWidget extends GetView<PersonController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact us' , style: TextStyle(color: Colors.black),),
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon: Icon(Icons.arrow_back , color: Colors.black,)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w , vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Contact Us",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "If you have any questions or need assistance, please feel free to contact us at:",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 5),
            InkWell(
              onTap: () {
                controller.launchEmail();
              },
              child: Text(
                "Email: ${controller.emailAddress}",
                style: TextStyle(fontSize: 16 , color: Colors.blue, decoration: TextDecoration.underline),
              ),
            ),
            Text(
              "Phone: +1 (123) 456-7890",
              style: TextStyle(fontSize: 16),
            ),
            // Add more contact information as needed
          ],
        ),
      ),
    );
  }
}
