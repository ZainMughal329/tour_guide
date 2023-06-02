import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'index.dart';

class MapController extends GetxController {
  final state = MapState();
  MapController();

  late final CameraPosition cameraPosition;
  late final Completer<GoogleMapController> completer;
  final List<Marker> marker = [];
  final List<Marker> _list = const [
    Marker(
        markerId: MarkerId('1'),
        infoWindow: InfoWindow(title: 'My Position'),
        position: LatLng(37.42796133580664, -122.085749655962)),
    Marker(
        markerId: MarkerId('2'),
        infoWindow: InfoWindow(title: 'My Position 2'),
        position: LatLng(37.52796133580664, -122.085749655962)),
    Marker(
        markerId: MarkerId('3'),
        infoWindow: InfoWindow(title: 'My Position 3'),
        position: LatLng(35.42796133580664, -122.085749655962)),
    Marker(
        markerId: MarkerId('4'),
        infoWindow: InfoWindow(title: 'My Position 4'),
        position: LatLng(34.42796133580664, -122.085749655962)),
    Marker(
        markerId: MarkerId('5'),
        infoWindow: InfoWindow(title: 'Sargodha'),
        position: LatLng(32.082466, 72.669128))
  ];


  Future<Position> getUserLocation() async {
    print('Enter in the function');
    await Geolocator.requestPermission().then((value) {

    }).onError((error, stackTrace) async{
      print(error.toString());
      await Geolocator.requestPermission();
    });
    return await Geolocator.getCurrentPosition();
  }


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    cameraPosition = CameraPosition(
      target: LatLng(32.0740, 72.6861),
      zoom: 14,
    );
    completer = Completer();
    marker.addAll(_list);



    getUserLocation();
  }

}
