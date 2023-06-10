import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../ReUsable/models/tourModel.dart';

class AdminController extends GetxController with GetTickerProviderStateMixin {
  late TabController tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void onClose() {
    super.onClose();
    tabController.dispose();
  }

  RxList<DocumentSnapshot> data = RxList<DocumentSnapshot>();
  final db = FirebaseFirestore.instance;
  CollectionReference ref = FirebaseFirestore.instance.collection('company');
  final firestore = FirebaseFirestore.instance
      .collection('company')
      .where('status', isEqualTo: 'false')
      .snapshots();

  final _db = FirebaseFirestore.instance;

  updateCompanyData(String id) async {
    print('Inside update');
    print('update id : ' + id);
    await ref.doc(id).update({
      'status': 'true',
    }).then((value) {
      Get.snackbar('St', 'Congrats');
    }).onError((error, stackTrace) {
      Get.snackbar('Error', 'Something went wrong');
    });
  }

  deleteCompanyData(String id) async {
    await ref.doc(id).delete().then((value) {
      Get.snackbar('Delete', 'Successfully Deleted');
    }).onError((error, stackTrace) {
      Get.snackbar('Error', 'Something went wrong');
    });
  }

  Future<List<TourModel>> getAllTourData() async {
    final snapshot = await _db.collection('allTours').get();
    final tourData = snapshot.docs.map((e) => TourModel.fromJson(e)).toList();
    return tourData;
  }

  Future<List<TourModel>> getAndShowALlToursData() async {
    return await getAllTourData();
  }
}
