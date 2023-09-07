import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class FAQsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Replace this with your FAQ data or a data source
    List<FAQItem> faqs = [
      FAQItem(
        question: "How do I book a tour?",
        answer: "You can book a tour by navigating to the 'Tours' section...",
      ),
      FAQItem(
        question: "What is the cancellation policy?",
        answer: "Our cancellation policy allows you to cancel up to 24 hours...",
      ),

      FAQItem(
        question: "How to add payment card?",
        answer: "Go to profile page and from there you can add a card...",
      ),

      FAQItem(
        question: "How to search a tour?",
        answer: "The tour can be search from search screen...",
      ),

      FAQItem(
        question: "What is the cancellation policy?",
        answer: "Our cancellation policy allows you to cancel up to 24 hours...",
      ),
      FAQItem(
        question: "How do I book a tour?",
        answer: "You can book a tour by navigating to the 'Tours' section...",
      ),
      FAQItem(
        question: "What is the cancellation policy?",
        answer: "Our cancellation policy allows you to cancel up to 24 hours...",
      ),

      FAQItem(
        question: "How to add payment card?",
        answer: "Go to profile page and from there you can add a card...",
      ),

      FAQItem(
        question: "How to search a tour?",
        answer: "The tour can be search from search screen...",
      ),

      FAQItem(
        question: "What is the cancellation policy?",
        answer: "Our cancellation policy allows you to cancel up to 24 hours...",
      ),
      // Add more FAQ items as needed
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ\'s' , style: TextStyle(color: Colors.black),),
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
              Text(
                "Frequently Asked Questions",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                itemCount: faqs.length,
                itemBuilder: (context, index) {
                  return ExpansionTile(
                    title: Text(faqs[index].question),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(faqs[index].answer),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FAQItem {
  final String question;
  final String answer;

  FAQItem({
    required this.question,
    required this.answer,
  });
}
