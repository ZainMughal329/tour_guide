import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';

import 'index.dart';

class CompanyAddTourController extends GetxController {
  CompanyAddTourController();

  final state = CompanyAddTourState();
  final auth = FirebaseAuth.instance;

  Stream<DocumentSnapshot<Map<String, dynamic>>> getNodeData() {
    return FirebaseFirestore.instance
        .collection('company')
        .doc(auth.currentUser!.uid.toString())
        .snapshots();
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
      Navigator.pop(context);
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
      Navigator.pop(context);
    }
  }
}
