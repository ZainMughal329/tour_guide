import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tours_guide/ReUsable/Components/snackBar.dart';
import 'package:tours_guide/ReUsable/models/companyModel.dart';
import 'package:tours_guide/ReUsable/models/tourModel.dart';
import 'package:tours_guide/pages/screens/home_screen/state.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../ReUsable/models/msg_model.dart';
import '../../../ReUsable/models/userModel.dart';
// import 'package:geocoding/geocoding.dart';

class HomeController extends GetxController {
  final state = HomeState();
  final auth = FirebaseAuth.instance;
  final userRef=FirebaseFirestore.instance.collection("users");

  final fireStoreTourRef = FirebaseFirestore.instance
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
    final snapshot = await _db.collection('allTours').get();
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
      'Adventure',
      'Cultural',
      'Hiking',
      'Mountains',
      'Favourites',
      '2 persons',
    ];
  }

  openwhatsapp(BuildContext context, String phone) async {
    final Uri whatsapp = Uri.parse(phone);
    final Uri whatsappURl_android = Uri.parse(
        "whatsapp://send?phone=" + whatsapp.toString() + "&text=hello");
    // var whatappURL_ios ="https://wa.me/$whatsapp?text=${Uri.parse("hello")}";

    // android , web
    if (await canLaunchUrl(whatsappURl_android)) {
      await launchUrl(whatsappURl_android);
    }
  }

  Future<void> fetchUserData() async{
  try{
    final userNode= await userRef.doc(auth.currentUser!.uid.toString()).get();

    state.name=userNode['userName'];
    state.phoneNumber=userNode['phone'];
  }catch(e){
Snackbar.showSnackBar("Error: ", e.toString());
  }

  }



// openWhatsApp(BuildContext context , String phone) async{
  //   final Uri phoneNumber = Uri.parse(phone);
  //   final Uri whatsApp = Uri.parse('https://wa.me/1XXXXXXXXXX');
  //
  // }
}
