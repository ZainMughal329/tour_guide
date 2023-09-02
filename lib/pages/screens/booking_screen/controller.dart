import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tours_guide/pages/screens/booking_screen/state.dart';

class BookingController extends GetxController{
  final state = BookingState();
  // BookingController();
  final auth = FirebaseAuth.instance;
  final dbref = FirebaseFirestore.instance.collection("usersBookings");




  Future<void> addBookings ()async{
    try{
      await dbref.doc(auth.currentUser!.uid.toString()).collection(
          DateTime.timestamp().microsecondsSinceEpoch.toString()
      ).add({

      }).then((value){

      }).onError((error, stackTrace) {

      });

    }catch(e){

    }
  }



}

