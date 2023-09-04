import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tours_guide/ReUsable/models/tourModel.dart';
import 'package:tours_guide/pages/screens/catogery_screen/index.dart';
import 'package:tours_guide/pages/screens/home_screen/state.dart';

import '../../../ReUsable/models/userModel.dart';
// import 'package:geocoding/geocoding.dart';

class catogeryScreenController extends GetxController {
  final state = catogeryScreenState();
  final auth = FirebaseAuth.instance;

  final userRef = FirebaseFirestore.instance.collection('users');
  void setTourRef(String catogery){

     state.fireStoreTourRef=  FirebaseFirestore.instance
        .collection('allTours')
        .where('tourCategory', isEqualTo: catogery)
        .snapshots();
  }

  void setRatingTourRef(String catogery){

    state.fireStoreTourRef=  FirebaseFirestore.instance
        .collection('allTours')
        .where('people', isEqualTo: "2")
        .snapshots();
  }

@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // setTourRef(catogery);

  }


  Stream<DocumentSnapshot<Map<String, dynamic>>> getCurrentUserData() {
    return userRef.doc(auth.currentUser!.uid.toString()).snapshots();
  }
}
