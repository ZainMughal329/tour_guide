import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CommunityGuidelinesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Community Guidelines' , style: TextStyle(color: Colors.black),),
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon: Icon(Icons.arrow_back , color: Colors.black,)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w , vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GuidelineItem(
                title: 'Be Respectful',
                description:
                'Treat fellow travelers and locals with respect and courtesy. Avoid offensive, discriminatory, or harmful language or behavior. Respect local customs and cultures when visiting new places.',
              ),
              GuidelineItem(
                title: 'Keep it Safe',
                description:
                'Prioritize safety in all your travel experiences. Share helpful safety tips and advice with the community. Report any unsafe or inappropriate content or behavior to our support team.',
              ),
              GuidelineItem(
                title: 'Authenticity Matters',
                description:
                'Be honest about your travel experiences and reviews. Do not engage in fake reviews or misleading information. Share authentic and helpful insights with other users.',
              ),
              GuidelineItem(
                title: 'Protect Privacy',
                description:
                'Respect the privacy of others, including fellow travelers and locals. Do not share personal information, contact details, or private messages without consent. Follow our privacy policy and respect user preferences regarding sharing location data.',
              ),
              // Add more guideline items as needed
            ],
          ),
        ),
      ),
    );
  }
}

class GuidelineItem extends StatelessWidget {
  final String title;
  final String description;

  GuidelineItem({
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            description,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 20),
        ],
      )
    ;
  }
}