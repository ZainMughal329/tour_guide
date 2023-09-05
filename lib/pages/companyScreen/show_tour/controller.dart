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

  final state = CompanyShowTourState();
  final dbCompany = FirebaseFirestore.instance.collection("company");

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

  Future<void> fetchCompanyId()async{
    state.companyId = await auth.currentUser!.uid.toString();
  }
  Future<void> fetchCompanyName() async{
    final companyDoc = await dbCompany.doc(state.companyId).get();
    if(companyDoc !=null){
      state.companyName = companyDoc["CompanyName"];
    }
  }






  deleteTour(String id) async {
    print('id is : ' + id.toString());
    await _db.doc(id).delete();
    await _dbTours.doc(id).delete();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getNodeData(String id) {
    return FirebaseFirestore.instance
        .collection('company')
        .doc(id)
        .snapshots();
  }

  final picker = ImagePicker();

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  XFile? _image;

  XFile? get image => _image;

  Future pickedImageFromGallery(BuildContext context, String id) async {
    final pickedImage =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);

    if (pickedImage != null) {
      _image = XFile(pickedImage.path);
      uploadImage(context, id);
      update();
    }
  }

  //
  Future pickedImageFromCamera(BuildContext context, String id) async {
    final pickedImage =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 100);

    if (pickedImage != null) {
      _image = XFile(pickedImage.path);
      uploadImage(context, id);
      // notifyListeners();
      update();
    }
  }

  void showImage(context, String id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Container(
            height: 130,
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    pickedImageFromCamera(context, id);
                    Navigator.pop(context);
                  },
                  leading: Icon(Icons.camera),
                  title: Text('Camera'),
                ),
                ListTile(
                  onTap: () {
                    pickedImageFromGallery(context, id);
                    Navigator.pop(context);
                  },
                  leading: Icon(Icons.image),
                  title: Text('Gallery'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future uploadImage(BuildContext context, String id) async {
    // setLoading(true);
    firebase_storage.Reference storageRef = firebase_storage
        .FirebaseStorage.instance
        .ref('/tourImage' + DateTime.now().toString());
    firebase_storage.UploadTask uploadTask =
        storageRef.putFile(File(image!.path).absolute);

    await Future.value(uploadTask);

    final newUrl = await storageRef.getDownloadURL();

    _db.doc(id).update({
      'tourImage': newUrl.toString(),
    }).then((value) {
      // setLoading(false);
      Get.snackbar('Congrats', 'Update successfully');
      _image = null;
    }).onError((error, stackTrace) {
      // setLoading(false);
      Get.snackbar('Error is', error.toString());
    });
    _dbTours.doc(id).update({
      'tourImage': newUrl.toString(),
    });
  }

  Future<TourModel> getUserData(String id) async {
    final snapshot = await _db.where('id', isEqualTo: id).get();
    final tourData = snapshot.docs.map((e) => TourModel.fromJson(e)).single;
    return tourData;
  }

  getUsersData(String id) async {
    if (id != '') {
      return await getUserData(id);
    } else {
      Get.snackbar('Error', 'Something went wrong');
    }
  }

  updateUserData(TourModel tourModel, String id) async {
    await _db.doc(id).update(tourModel.toJson()).then((value) {
      toastInfo(msg: 'Successfully update user data');
    }).onError((error, stackTrace) {
      toastInfo(msg: 'Something went wrong.');
    });
    await _dbTours.doc(id).update(
          tourModel.toJson(),
        );
  }

  updateTour(TourModel tourModel, String id) async {
    await updateUserData(tourModel, id);
  }
}
