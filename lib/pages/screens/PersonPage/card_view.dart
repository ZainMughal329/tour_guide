import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tours_guide/ReUsable/Components/app_colors.dart';
import 'package:tours_guide/pages/screens/PersonPage/add_card.dart';
import 'package:tours_guide/pages/screens/PersonPage/controller.dart';
import 'package:tours_guide/pages/screens/booking_screen/controller.dart';

class PaymentView extends GetView<PersonController> {
  const PaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back , color: AppColors.lightBgColor,),
        ),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),

      body: Container(
        width: Get.width,
        height: Get.height,
        child: Stack(
          children: [
            Container(
              height: 220,
              width: double.infinity,
              color: Colors.blueAccent,
              child: Center(
                child: Text(
                  'Your Card',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.white),
                ),
              ),
            ),
            Positioned(
              top: 120,
              right: 0,
              left: 0,
              bottom: 80,
              child: StreamBuilder<QuerySnapshot>(
                  stream: controller.getUserCards,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return snapshot.data!.docs.length != 0
                          ? ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                return CreditCardWidget(
                                  cardBgColor: Colors.blueGrey,
                                  cardNumber: snapshot.data!.docs[index]
                                      ['cardNumber'],
                                  expiryDate: snapshot.data!.docs[index]
                                      ['expiryDate'],
                                  cardHolderName: snapshot.data!.docs[index]
                                      ['name'],
                                  cvvCode: snapshot.data!.docs[index]['cvv'],
                                  bankName: '',
                                  showBackView: false,
                                  obscureCardNumber: true,
                                  obscureCardCvv: true,
                                  isHolderNameVisible: true,
                                  isSwipeGestureEnabled: true,
                                  onCreditCardWidgetChange:
                                      (CreditCardBrand creditCardBrand) {},
                                );
                              },
                            )
                          : Center(
                            child: Text(
                                'No card added yet',
                                style: TextStyle(
                                    color: AppColors.lightTextColor,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                          );
                    }else if(snapshot.hasError) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }else {
                      return Center(child: Text('Something went wrong'));
                    }
                  }),
            ),
            Positioned(
                bottom: 10,
                right: 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Add new card',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    FloatingActionButton(
                      backgroundColor: Colors.blue,
                      onPressed: () {
                        Get.to(
                          () => AddPaymentCard(),
                        );
                      },
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
