import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tours_guide/ReUsable/Components/toast_info.dart';
import 'package:tours_guide/ReUsable/models/tourModel.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:tours_guide/ReUsable/routes/names.dart';

import 'index.dart';

class CompanyShowTourController extends GetxController {
  CompanyShowTourController();

  var auth = FirebaseAuth.instance;

  final firestore = FirebaseFirestore.instance
      .collection('company')
      .doc(FirebaseAuth.instance.currentUser!.uid.toString())
      .collection('tour')
      .snapshots();

  final _db = FirebaseFirestore.instance
      .collection('company')
      .doc(FirebaseAuth.instance.currentUser!.uid.toString())
      .collection('tour');
  
  final _dbTours = FirebaseFirestore.instance.collection('allTours');
  // if(k.de)

deleteTour(String id) async{
  print('id is : ' + id.toString());
  await _db.doc(id).delete();
  await _dbTours.doc(id).delete();
}

updateTour(String id , TourModel tourModel) async {
  // await _db.doc(id).delete();
  // await _dbTours.doc(id).delete();
}


}
