import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tours_guide/ReUsable/Components/snackBar.dart';
import 'package:tours_guide/ReUsable/models/bookingMode.dart';
import 'package:tours_guide/ReUsable/routes/pages.dart';
import 'package:tours_guide/pages/screens/booking_screen/state.dart';

class BookingController extends GetxController {
  final state = BookingState();
  // BookingController();
  final auth = FirebaseAuth.instance;
  final dbref = FirebaseFirestore.instance.collection("usersBookings");
  // final companyRef = FirebaseFirestore.instance.collection("usersBookings");

  Future<void> fetchDetails(String tourId) async {
    final tourDoc = await FirebaseFirestore.instance
        .collection("allTours")
        .doc(tourId)
        .get();
    if (tourDoc != null) {
      state.companyId = tourDoc["companyId"];
      state.pricePerPerson = tourDoc["price"];
      state.tourImgae = tourDoc["tourImage"];
      state.tourTitle = tourDoc["title"];
      state.companyName = tourDoc["companyName"];

    }
  }

  Future<void> addBookings(BookingModel booking) async {
    try {
      await dbref
          .doc(auth.currentUser!.uid.toString())
          .collection(DateTime.timestamp().microsecondsSinceEpoch.toString())
          .add(booking.toJson())
          .then((value) {
        Get.toNamed(AppPages.APPlication);
      }).onError((error, stackTrace) {});
    } catch (e) {
      Snackbar.showSnackBar("Error", e.toString());
    }
  }
}
