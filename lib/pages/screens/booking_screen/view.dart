import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tours_guide/pages/screens/booking_screen/controller.dart';

class BookingView extends GetView<BookingController> {
  const BookingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Booking Screen"),),
    );
  }
}
