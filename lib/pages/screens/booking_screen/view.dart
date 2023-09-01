import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tours_guide/pages/screens/booking_screen/controller.dart';

class BookingView extends GetView<BookingController> {
  String tourId;
   BookingView({required this.tourId,Key? key}) : super(key: key);
   // final controller = Get.put<BookingController>(BookingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                child: Image(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/images/booking.jpg'),
                )

              ),
            ),
            // Expanded(
            //   // flex: 3,
            //   child: Container(
            //     color: Colors.green,
            //
            //   ),
            // ),
          ],
        ),
      ),

    );
  }
}
