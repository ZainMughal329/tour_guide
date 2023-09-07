import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:get/get.dart';
import 'package:tours_guide/ReUsable/Components/snackBar.dart';
import 'package:tours_guide/ReUsable/models/bookingMode.dart';
import 'package:tours_guide/ReUsable/routes/names.dart';
import 'package:tours_guide/ReUsable/routes/pages.dart';
import 'package:tours_guide/pages/screens/booking_screen/state.dart';

class BookingController extends GetxController {
  final state = BookingState();

  // BookingController();
  final auth = FirebaseAuth.instance;
  final dbref = FirebaseFirestore.instance.collection("usersBookings");
  final allbookingRef = FirebaseFirestore.instance.collection("allUserBookings");

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
    setLoading(true);
    try{
      state.uid = await auth.currentUser!.uid.toString();
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
    }catch(e){
      setLoading(false);
      Snackbar.showSnackBar("Error while fetching User Details", e.toString());
    }
  }
  void setLoading(bool value){
    state.loading.value = value;
  }

  Future<void> addBookings(BookingModel booking) async {
    setLoading(true);
    try {
      await dbref
          .doc(state.uid.toString())
          .collection('AllBookings')
          .doc(DateTime.timestamp().microsecondsSinceEpoch.toString())
          .set(booking.toJson())
          .then((value) async{
await addinAllBookings(booking);
      }).onError((error, stackTrace) {
        setLoading(false);
        Snackbar.showSnackBar("Error", error.toString());
      });
    } catch (e) {
      setLoading(false);
      Snackbar.showSnackBar("Error", e.toString());
    }
  }
  Future<void> addinAllBookings(BookingModel bookingData) async{
    await allbookingRef.doc(DateTime.timestamp().microsecondsSinceEpoch.toString()).set(bookingData.toJson()).then((value){
      setLoading(false);
      Get.offAllNamed(AppRoutes.Application);
      Snackbar.showSnackBar("Congrats", "Tour Booked Successfully");
    }).onError((error, stackTrace){
      setLoading(false);
      Snackbar.showSnackBar("Error while adding to bookings", error.toString());
    });
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
