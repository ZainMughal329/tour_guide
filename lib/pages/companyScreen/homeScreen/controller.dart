import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tours_guide/pages/companyScreen/homeScreen/index.dart';

import '../../../ReUsable/models/companyModel.dart';

class CompanyHomeController extends GetxController {
  final state=CompanyHomeState();
  final auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance.collection('company');

  Future<CompanyModel> getUserData(String id) async {
    final snapshot = await _db.where('id', isEqualTo: id).get();
    final comData = snapshot.docs.map((e) => CompanyModel.fromJson(e)).single;
    return comData;
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getNodeData() {
    return FirebaseFirestore.instance
        .collection('company')
        .doc(FirebaseAuth.instance.currentUser!.uid.toString())
        .snapshots();
  }
  getUsersData() async {
    print('INSIDE FUNC');
    final id = auth.currentUser!.uid.toString();
    if (id != '') {
      print('object');
      final data = await getUserData(id);
      return data;
    } else {
      Get.snackbar('Error', 'Something went wrong');
    }
  }


}
