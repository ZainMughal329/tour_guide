import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tours_guide/ReUsable/Components/snackBar.dart';
import 'package:tours_guide/ReUsable/Components/toast_info.dart';
import 'package:tours_guide/ReUsable/models/tourModel.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:tours_guide/ReUsable/routes/names.dart';

import 'index.dart';

class CompanyAddTourController extends GetxController {
  CompanyAddTourController();

  final state = CompanyAddTourState();
  final auth = FirebaseAuth.instance;
  final dbCompany = FirebaseFirestore.instance.collection("company");
  final allTours = FirebaseFirestore.instance.collection("allTours");

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Stream<DocumentSnapshot<Map<String, dynamic>>> getNodeData() {
    return FirebaseFirestore.instance
        .collection('company')
        .doc(auth.currentUser!.uid.toString())
        .snapshots();
  }

  dispose() {
    _image = null;
    state.titleController.clear();
    state.locationController.clear();
    state.priceController.clear();
    state.descrepController.clear();
    state.catValue.value = "";
    state.tourPeople.value = "";
  }

  Future<void> fetchCompanyId()async{
    state.companyId = await auth.currentUser!.uid.toString();
  }
  Future<void> fetchCompanyName() async{
    final companyDoc = await dbCompany.doc(state.companyId).get();
    if(companyDoc !=null){
      state.companyName = companyDoc["CompanyName"];
    }
  }


  final picker = ImagePicker();

  XFile? _image;

  XFile? get image => _image;

  void pickedImageFromGallery(
    BuildContext context,
  ) async {
    final pickedImage =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);

    if (pickedImage != null) {
      _image = XFile(pickedImage.path);

      update();
    }
  }

  //
  void pickedImageFromCamera(
    BuildContext context,
  ) async {
    final pickedImage =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 100);
    if (pickedImage != null) {
      _image = XFile(pickedImage.path);
      update();
    }

  }

  void addTour(
      String title,
      String location,
      String tourDescription,
      String tourCategory,
      String people,
      String price,
      String tourImage,
      String companyId,
      String comapnyName,
      ) async {
    state.loading.value = true;
    String timeStamp = DateTime.now().microsecondsSinceEpoch.toString();
    final companyDoc = await dbCompany.doc(auth.currentUser!.uid).get();
    final companyPhone = companyDoc.data()!['companyPhone'];
    print('Data is: ' + companyPhone.toString());
    try {
      await dbCompany
          .doc(auth.currentUser!.uid.toString())
          .collection('tour')
          .doc(timeStamp)
          .set(
            TourModel(
              id: timeStamp,
              title: title,
              tourCategory: tourCategory,
              tourDescription: tourDescription,
              tourImage: tourImage,
              location: location,
              people: people,
              price: price,
              companyPhone: companyPhone,
              companyId: companyId,
              companyName: comapnyName

            ).toJson(),
          )
          .then((value) async {
        await allTours
            .doc(timeStamp)
            .set(TourModel(
              id: timeStamp,
              title: title,
              tourCategory: tourCategory,
              tourDescription: tourDescription,
              tourImage: tourImage,
              location: location,
              people: people,
              price: price,
              companyPhone: companyPhone,
          companyId: companyId,
          companyName: comapnyName
            ).toJson())
            .then((value) {
          // toastInfo(msg: "Successfully Added Tour");
          Snackbar.showSnackBar("Congratulations", "Tour Added Successfully");
          // toastInfo(msg: "Updating ...");

          uploadImage(timeStamp);
          Get.offAllNamed(AppRoutes.Company_Home);
        }).onError((error, stackTrace) {
          state.loading.value = false;
        });
      }).onError((error, stackTrace) {});

      //
      // await _dbCompany.doc(auth.currentUser!.uid.toString()).collection(timeStamp).add(tour.toJson()).then((value)async{
      //

      //
      // }).onError((error, stackTrace){
      //   print("error in ading tour");
      //   toastInfo(msg: "Error");
      //   toastInfo(msg: error.toString());
      //
      // });
    } catch (e) {
      // toastInfo(msg: e.toString());
      Snackbar.showSnackBar("Error",e.toString());
    }
  }

  Future uploadImage(String timeStamp) async {
    // Get.snackbar('Wait', "Updating...");
    Snackbar.showSnackBar("Wait", "Updating ...");
    state.loading.value = true;
    firebase_storage.Reference storageRef =
        firebase_storage.FirebaseStorage.instance.ref('/tourPic' + timeStamp);
    firebase_storage.UploadTask uploadTask =
        storageRef.putFile(File(image!.path).absolute);

    await Future.value(uploadTask);

    final newUrl = await storageRef.getDownloadURL();

    dbCompany
        .doc(auth.currentUser!.uid.toString())
        .collection('tour')
        .doc(timeStamp)
        .update({
      "tourImage": newUrl.toString(),
    }).then((value) async {
      await allTours.doc(timeStamp).update({
        "tourImage": newUrl.toString(),
      }).then((value) {
        state.loading.value = false;
        // Get.snackbar('Congrats', 'Update Successfully');
        Snackbar.showSnackBar("Congrats ", "Updated Successfully");


        dispose();

        _image = null;
      }).onError((error, stackTrace) {
        state.loading.value = false;
        // Get.snackbar('Error Occurred', error.toString());
        Snackbar.showSnackBar("Error Occurred ", error.toString());
      });
    }).onError((error, stackTrace) {
      state.loading.value = false;
      // Get.snackbar('Error Occurred', error.toString());
      Snackbar.showSnackBar("Error Occurred ", error.toString());
    });
  }
}
