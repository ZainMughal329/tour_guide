import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tours_guide/ReUsable/models/bookingMode.dart';
import 'package:tours_guide/ReUsable/models/tourModel.dart';
import 'package:tours_guide/pages/screens/user_bookings/state.dart';

import '../../../ReUsable/models/userModel.dart';

class UserBookingController extends GetxController {
  final state = UserBookingState();

  final _db = FirebaseFirestore.instance.collection('usersBookings');
  final auth = FirebaseAuth.instance;

  Future<void> getUid() async {
    state.uid = await auth.currentUser!.uid.toString();
  }

  final allBookings = FirebaseFirestore.instance
      .collection('usersBookings')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('AllBookings')
      .snapshots();

  Future<List<BookingModel>> getAllTourData() async {
    final snapshot = await _db.doc(state.uid).collection("AllBookings").get();
    // final snapshot = await _db.doc(bookingRef).get();
    final bookingData =
        snapshot.docs.map((e) => BookingModel.fromJson(e)).toList();
    return bookingData;
  }

  Future<List<BookingModel>> getAndShowALlToursData() async {
    return await getAllTourData();
  }



  getUsersData() async {
    final id = auth.currentUser!.uid.toString();
    if (id != '') {
      return await getUserData(id);
    } else {
      Get.snackbar('Error', 'Something went wrong');
    }
  }

  final db = FirebaseFirestore.instance;

  Future<UserModel> getUserData(String id) async {
    final snapshot =
    await db.collection('users').where('id', isEqualTo: id).get();
    final userData = snapshot.docs.map((e) => UserModel.fromJson(e)).single;
    return userData;
  }
}
