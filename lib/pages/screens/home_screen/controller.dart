import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tours_guide/ReUsable/Components/snackBar.dart';
import 'package:tours_guide/ReUsable/models/companyModel.dart';
import 'package:tours_guide/ReUsable/models/fvrt_tour_model.dart';
import 'package:tours_guide/ReUsable/models/tourModel.dart';
import 'package:tours_guide/pages/screens/home_screen/state.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../ReUsable/models/msg_model.dart';
import '../../../ReUsable/models/userModel.dart';
// import 'package:geocoding/geocoding.dart';

class HomeController extends GetxController {
  final state = HomeState();
  final auth = FirebaseAuth.instance;
  final userRef = FirebaseFirestore.instance.collection("users");

  final firestore =
      FirebaseFirestore.instance.collection('allTours').snapshots();

  late final List<String> category;

  // String dc_id = DateTime.timestamp().microsecondsSinceEpoch.toString();

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

  Stream<DocumentSnapshot<Map<String, dynamic>>> getCurrentUserData() {
    return userRef.doc(auth.currentUser!.uid.toString()).snapshots();
  }

  Future<List<TourModel>> getAllTourData() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('allTours').get();
    final tourData = snapshot.docs.map((e) => TourModel.fromJson(e)).toList();
    return tourData;
  }

  Future<List<TourModel>> getAndShowALlToursData() async {
    return await getAllTourData();
  }

  openWhatsapp(BuildContext context, String phone) async {
    // final Uri whatsapp = Uri.parse(phone);
    // final Uri whatsappURl_android = Uri.parse(
    //     "whatsapp://send?phone=" + whatsapp.toString() + "&text=hello");
    // // var whatappURL_ios ="https://wa.me/$whatsapp?text=${Uri.parse("hello")}";
    //
    // // android , web
    // if (await canLaunchUrl(whatsappURl_android)) {
    //   await launchUrl(whatsappURl_android);
    // }

    // final phoneNumber = phone; // Replace with the recipient's phone number
    // final message = 'Hello, this is a test message!'; // Optional: Replace with your message
    //
    // final whatsappUrl = Uri.parse("https://wa.me/$phoneNumber/?text=${Uri.encodeFull(message)}");
    //
    // if (await canLaunch(whatsappUrl.toString())) {
    //   await launch(whatsappUrl.toString());
    // } else {
    //   Get.snackbar(
    //     'Error',
    //     'Could not launch WhatsApp. Make sure WhatsApp is installed on your device.',
    //     snackPosition: SnackPosition.BOTTOM,
    //   );
    // }

    var whatsapp = phone;
    var whatsappURl_android =
        "whatsapp://send?phone=" + whatsapp + "&text=hello";
    var whatappURL_ios = "https://wa.me/$whatsapp?text=${Uri.parse("hello")}";
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunch(whatappURL_ios)) {
        await launch(whatappURL_ios, forceSafariVC: false);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
      }
    } else {
      // android , web
      if (await canLaunch(whatsappURl_android)) {
        await launch(whatsappURl_android);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
      }
    }
  }

  Future<void> fetchUserData() async {
    try {
      final userNode =
          await userRef.doc(auth.currentUser!.uid.toString()).get();

      state.name = userNode['userName'];
      state.phoneNumber = userNode['phone'];
    } catch (e) {
      Snackbar.showSnackBar("Error: ", e.toString());
    }
  }
  //
  // addToFavouriteList(FvrtTourModel tourModel,String id) async {
  //   await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(auth.currentUser!.uid)
  //       .collection('fvrt')
  //       .doc(id)
  //       .set(tourModel.toJson())
  //       .then((value) {
  //     Snackbar.showSnackBar('Success', 'Added to fvrt');
  //   }).onError((error, stackTrace) {
  //     // print('Error is : ' + error.toString());
  //   });
  // }
  //
  // removeFromFavouriteList(
  //   String id,
  // ) async {
  //   QuerySnapshot querySnapshot = await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(auth.currentUser!.uid)
  //       .collection('fvrt')
  //       .where('id', isEqualTo: id)
  //       .get();
  //   querySnapshot.docs.forEach((doc) async {
  //     await doc.reference.delete().then((value) {
  //       Snackbar.showSnackBar('Success', 'Delete from fvrt');
  //     }).onError((error, stackTrace) {
  //       // print('Error is : ' + error.toString());
  //     });
  //   });
  // }
  //
  // updateFvrValue(String id) async {
  //   await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(auth.currentUser!.uid)
  //       .collection('fvrt')
  //       .doc(id)
  //       .update(
  //     {
  //       'isFavourite': state.isFavourite.value,
  //     },
  //   );
  // }
  //
  // RxBool fieldValue = false.obs;
  //
  // Future<void> getData(String id) async {
  //   try {
  //     // Get a reference to the document
  //     DocumentReference docRef = FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(auth.currentUser!.uid)
  //         .collection('fvrt')
  //         .doc(id);
  //
  //     // Retrieve the document
  //     DocumentSnapshot doc = await docRef.get();
  //
  //     // Check if the document exists
  //     if (doc.exists) {
  //       // Access a specific field ('field_name' in this example)
  //       state.isFavourite.value = doc['isFavourite'];
  //       print('Value of field_name: $fieldValue');
  //     } else {
  //       print('Document does not exist');
  //     }
  //   } catch (e) {
  //     // print('Error getting data: $e');
  //   }
  // }
  //
  // getParticularTourData(String id) async {
  //   await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(auth.currentUser!.uid)
  //       .collection('fvrt')
  //       .doc(id)
  //       .snapshots();
  // }
  //
  // Future<bool> isFavorite(String tourId) async {
  //   // Get a reference to the document
  //   DocumentReference docRef = FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(auth.currentUser!.uid)
  //       .collection('fvrt')
  //       .doc(tourId);
  //
  //   // Retrieve the document
  //   DocumentSnapshot doc = await docRef.get();
  //
  //   // Check if the document exists
  //   if (doc.exists) {
  //     // Access a specific field ('field_name' in this example)
  //     print('Exist with id : ' + tourId);
  //     return true;
  //   } else {
  //     print('Document does not exist');
  //     return false;
  //   }
  // }
  //
  // Future<void> toggleFavorite(final String id, FvrtTourModel tourModel) async {
  //   // Check if the tour ID already exists in favorites
  //   updateFvrValue(id);
  //   bool exists = await isFavorite(id);
  //
  //   if (exists) {
  //     // If it exists, remove it from favorites
  //     await removeFromFavouriteList(id);
  //   } else {
  //     // If it doesn't exist, add it to favorites
  //     await addToFavouriteList(tourModel , id);
  //   }
  // }
}
