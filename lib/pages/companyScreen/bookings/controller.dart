import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class CompanyBookingController extends GetxController {
  final auth = FirebaseAuth.instance;








  Stream<QuerySnapshot<Map<String, dynamic>>> getNodeData(String uid) {

// print("query code");
    return FirebaseFirestore.instance
        .collection('allUserBookings').where('CompanyId', isEqualTo: uid).snapshots();
  }


  
}