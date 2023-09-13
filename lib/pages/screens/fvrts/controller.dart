import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tours_guide/ReUsable/models/bookingMode.dart';
import 'package:tours_guide/ReUsable/models/tourModel.dart';
import 'package:tours_guide/pages/screens/fvrts/state.dart';
import 'package:tours_guide/pages/screens/user_bookings/state.dart';

import '../../../ReUsable/models/userModel.dart';

class FavouriteController extends GetxController {
  final state = FavouriteState();

  final _db = FirebaseFirestore.instance.collection('users');
  final auth = FirebaseAuth.instance;

  final fvrtTourData = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('fvrt')
      .snapshots();

  getUsersData() async {
    final id = auth.currentUser!.uid.toString();
    if (id != '') {
      return await getUserData(id);
    } else {
      Get.snackbar('Error', 'Something went wrong');
    }
  }

  Future<UserModel> getUserData(String id) async {
    final snapshot = await _db.where('id', isEqualTo: id).get();
    final userData = snapshot.docs.map((e) => UserModel.fromJson(e)).single;
    return userData;
  }


  FavouriteController();
}
