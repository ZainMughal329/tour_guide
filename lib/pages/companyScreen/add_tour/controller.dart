import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tours_guide/pages/companyScreen/company_profile/state.dart';

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
}
