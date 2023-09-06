import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tours_guide/ReUsable/models/bookingMode.dart';
import 'package:tours_guide/ReUsable/models/tourModel.dart';
import 'package:tours_guide/pages/screens/user_bookings/state.dart';

class UserBookingController extends GetxController{
  final state = UserBookingState();

  final _db = FirebaseFirestore.instance.collection('usersBookings');
  final auth = FirebaseAuth.instance;

  Future<void> getUid() async{
    state.uid= await auth.currentUser!.uid.toString();
  }



  Future<List<BookingModel>> getAllTourData() async {

    final snapshot = await _db.doc(state.uid).collection("AllBookings").get();
    // final snapshot = await _db.doc(bookingRef).get();
    final bookingData = snapshot.docs.map((e) => BookingModel.fromJson(e)).toList();
    return bookingData;
  }

  Future<List<BookingModel>> getAndShowALlToursData() async {
    return await getAllTourData();
  }

}