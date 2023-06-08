import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tours_guide/pages/screens/home_screen/state.dart';
// import 'package:geocoding/geocoding.dart';

class HomeController extends GetxController {
  final state = HomeState();

  final fireStoreTourRef= FirebaseFirestore.instance
      .collection('allTours')
      .where('id', isNotEqualTo: '')
      .snapshots();

  late final List<String> category;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    category = [
      'Best Places',
      'Most Visited',
      'Favourites',
      'Hotels',
      'New Added',
      'Restaurants',
    ];
  }
}
