import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TermsOfUseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Term of use',
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
            SectionTitle(title: '1. Acceptance of Terms'),
            Text(
              'By using Tour App, you agree to abide by these Terms of Use. If you do not agree with any part of these terms, please do not use our services.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),

            SectionTitle(title: '2. Use of Our Services'),
            Text(
              'You must use Tour App services in accordance with these terms and applicable laws. You agree not to misuse our services or engage in any illegal activities.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),

            // Add more sections as needed

            SectionTitle(title: '3. Contact Us'),
            Text(
              'If you have any questions or concerns about these Terms of Use, please contact us at thedevtech2022@gmail.com.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      )),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
