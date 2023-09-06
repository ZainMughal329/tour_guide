import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tours_guide/ReUsable/Components/app_bar.dart';
import 'package:tours_guide/ReUsable/Components/app_colors.dart';
import 'package:tours_guide/ReUsable/models/bookingMode.dart';
import 'package:tours_guide/pages/screens/user_bookings/controller.dart';

class UserBookingView extends GetView<UserBookingController> {
  const UserBookingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.getUid();
    return  Scaffold(
      appBar: AppBar(
        title: Text("My Bookings"),
      ),
      body: SafeArea(
        child: Container(
          child: FutureBuilder<List<BookingModel>>(
            future: controller.getAndShowALlToursData(),
            builder: (BuildContext context, snapshot){
              try{
                print('Inside try');
                if (snapshot.connectionState == ConnectionState.waiting) {
                  print('Connection is not ok');
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  print('Inside snapshot');
                  return Center(child: CircularProgressIndicator());
                }
                var len = snapshot.data!.length;
                print(len.toString());

              }
              catch(e){

              }
              return Container();
            },
          ),
        )
      ),
    );
  }
}
