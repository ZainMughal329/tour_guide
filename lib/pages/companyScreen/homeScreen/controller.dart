import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../ReUsable/models/companyModel.dart';
import '../../sessionPages/sigin/controller.dart';

class CompanyHomeController extends GetxController {
  // final signInController = Get.put(SignInController());
  final auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance.collection('company');

  Future<CompanyModel> getUserData(String id) async {
    final snapshot = await _db.where('id', isEqualTo: id).get();
    final comData = snapshot.docs.map((e) => CompanyModel.fromJson(e)).single;
    return comData;
  }
  getUsersData() async{
    print('INSIDE FUNC');
    final id = auth.currentUser!.uid.toString();
    print('Id is : ' +id.toString());
    if(id != '') {
      print('object');
      final data =  await getUserData(id);
      print('Data is : ' + data.toString());
      return data;
    }else {
      Get.snackbar('Error', 'Something went wrong');
    }
  }

}