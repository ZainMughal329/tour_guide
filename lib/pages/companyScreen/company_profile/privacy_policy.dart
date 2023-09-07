import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Privacy Policy',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Privacy Policy for Tour App',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Last Updated: 09/07/2023',
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(height: 20),
              Text(
                '1. Introduction',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Tour App ("us," "we," or "our") respects your privacy and is committed to protecting it through our compliance with this policy.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                '2. Information We Collect',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'We may collect and process personal information that you provide to us, such as:',
                style: TextStyle(fontSize: 16),
              ),
              Text('   - Name, email address, and other contact details.'),
              Text('   - Travel preferences and itinerary details.'),
              Text(
                'We may also collect information about your usage of our app, including device information, location data, and browsing history.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              // Add more sections as needed
            ],
          ),
        ),
      ),
    );
  }
}
