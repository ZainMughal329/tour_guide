import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:get/get.dart';
import 'package:tours_guide/ReUsable/Components/snackBar.dart';
import 'package:tours_guide/ReUsable/models/bookingMode.dart';
import 'package:tours_guide/ReUsable/routes/pages.dart';
import 'package:tours_guide/pages/screens/booking_screen/state.dart';

class BookingController extends GetxController {
  final state = BookingState();

  // BookingController();
  final auth = FirebaseAuth.instance;
  final dbref = FirebaseFirestore.instance.collection("usersBookings");

  // final companyRef = FirebaseFirestore.instance.collection("usersBookings");

  @override
  void onInit() {
    state.border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.withOpacity(0.7),
        width: 2.0,
      ),
    );
    super.onInit();
  }

  Future<void> fetchDetails(String tourId) async {
    final tourDoc = await FirebaseFirestore.instance
        .collection("allTours")
        .doc(tourId)
        .get();
    if (tourDoc != null) {
      state.companyId = tourDoc["companyId"];
      state.pricePerPerson = tourDoc["price"];
      state.tourImgae = tourDoc["tourImage"];
      state.tourTitle = tourDoc["title"];
      state.companyName = tourDoc["companyName"];
    }
  }

  Future<void> addBookings(BookingModel booking) async {
    try {
      await dbref
          .doc(auth.currentUser!.uid.toString())
          .collection('AllBookings')
          .doc(DateTime.timestamp().microsecondsSinceEpoch.toString())
          .set(booking.toJson())
          .then((value) {
        Get.toNamed(AppPages.APPlication);
      }).onError((error, stackTrace) {});
    } catch (e) {
      Snackbar.showSnackBar("Error", e.toString());
    }
  }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    state.cardNumber.value = creditCardModel!.cardNumber;
    state.expiryDate.value = creditCardModel.expiryDate;
    state.cardHolderName.value = creditCardModel.cardHolderName;
    state.cvvCode.value = creditCardModel.cvvCode;
    state.isCvvFocused.value = creditCardModel.isCvvFocused;
  }

  storeCardInfo(String cardNumber, expiryDate, cardHolderName, cvvCode) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('card')
        .doc(DateTime.timestamp().microsecondsSinceEpoch.toString())
        .set({
      'name': cardHolderName,
      'cardNumber': cardNumber,
      'cvv': cvvCode,
      'expiryDate': expiryDate,
    }).then((value) {
      state.cvvCode.value = '';
      state.cardHolderName.value = '';
      state.cardNumber.value = '';
      state.expiryDate.value = '';
      Get.snackbar('Success', 'Your Card is added successfully');


    }).onError((error, stackTrace) {
      Get.snackbar('Error', 'Error is:' + error.toString());
      print('Error is:' + error.toString());
    });
    return true;
  }

  final getUserCards = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('card')
      .snapshots();
}
