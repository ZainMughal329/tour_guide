import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tours_guide/ReUsable/models/tourModel.dart';

import '../../../ReUsable/models/userModel.dart';
import 'index.dart';

class SearchBarController extends GetxController {
  final state = SearchState();
  final auth = FirebaseAuth.instance;

  SearchBarController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  RxList<DocumentSnapshot> tourData = RxList<DocumentSnapshot>();
  RxList<DocumentSnapshot> filteredTourList = RxList<DocumentSnapshot>();


  // Initialize the controller and fetch data from Firestore
  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  // Fetch data from Firestore
  void fetchData() async {
    final querySnapshot =
    await FirebaseFirestore.instance.collection('allTours').get();

    print('Snapshot is : ' + querySnapshot.toString());
    tourData.assignAll(querySnapshot.docs);
  }


  // Search for tours based on a query
  void searchTours(String query) {
    final lowerCaseQuery = query.toLowerCase();
    List<DocumentSnapshot> results = [];
    if(query.isEmpty) {
      results = tourData;
    }else {
    results = tourData
        .where((ele) =>
    ele['title'].toString().toLowerCase().contains(lowerCaseQuery) ||
        ele['location'].toString().toLowerCase().contains(lowerCaseQuery) ||
        ele['tourCategory'].toString().toLowerCase().contains(lowerCaseQuery) ||
        ele['tourDescription'].toString().toLowerCase().contains(lowerCaseQuery))
        .toList();
  }
    filteredTourList.value = results;
  }
  toggleDropdown() {
    state.isDropdownOpen.value = !state.isDropdownOpen.value;
  }

  selectItem(String item) {
    state.selectedItem.value = item;
  }

  getUsersData() async {
    final id = auth.currentUser!.uid.toString();
    if (id != '') {
      return await getUserData(id);
    } else {
      Get.snackbar('Error', 'Something went wrong');
    }
  }

  final _db = FirebaseFirestore.instance;

  Future<UserModel> getUserData(String id) async {
    final snapshot =
        await _db.collection('users').where('id', isEqualTo: id).get();
    final userData = snapshot.docs.map((e) => UserModel.fromJson(e)).single;
    return userData;
  }
}
