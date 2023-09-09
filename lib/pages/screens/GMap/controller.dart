import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tours_guide/ReUsable/Components/snackBar.dart';
import 'package:tours_guide/pages/screens/GMap/state.dart';

class GMapController extends GetxController{

  final state = GMapState();




Future<Position> getCurrentLocation() async {
  await Geolocator.requestPermission().then((value)async{

  }).onError((error, stackTrace){

  });
  return await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.best,
  );


}

}