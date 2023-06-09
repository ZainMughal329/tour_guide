import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tours_guide/ReUsable/models/tourModel.dart';
import 'package:tours_guide/pages/screens/home_screen/state.dart';

import '../../../ReUsable/models/userModel.dart';
// import 'package:geocoding/geocoding.dart';

class HomeController extends GetxController {
  final state = HomeState();
  final auth = FirebaseAuth.instance;

  final fireStoreTourRef= FirebaseFirestore.instance
      .collection('allTours')
      .where('id', isNotEqualTo: '')
      .snapshots();

  late final List<String> category;

  Stream<DocumentSnapshot<Map<String, dynamic>>> getNodeData() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid.toString())
        .snapshots();
  }


  final _db = FirebaseFirestore.instance;
  Future<UserModel> getUserData(String id) async {
    final snapshot =
    await _db.collection('users').where('id', isEqualTo: id).get();
    final userData = snapshot.docs.map((e) => UserModel.fromJson(e)).single;
    return userData;
  }

  Future<List<TourModel>> getAllTourData() async {
    final snapshot =
    await _db.collection('allTours').get();
    final tourData = snapshot.docs.map((e) => TourModel.fromJson(e)).toList();
    return tourData;
  }

  Future<List<TourModel>> getAndShowALlToursData() async {
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
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    category = [
      'Best Places',
      'Most Visited',
      'Favourites',
      'Hotels',
      'New Added',
      'Restaurants',
    ];
  }
}
