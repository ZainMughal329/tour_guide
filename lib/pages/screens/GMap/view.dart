import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tours_guide/pages/screens/GMap/controller.dart';

class GMapView extends GetView<GMapController> {
  GMapView({Key? key}) : super(key: key);

  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          return GoogleMap(
            mapType: MapType.normal,
            zoomControlsEnabled: true,
            compassEnabled: true,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            initialCameraPosition: CameraPosition(
                target: controller.state.currentLocation.value, zoom: 14),
            onMapCreated: (GoogleMapController contr)  async{

              _controller.complete(contr);
              final GoogleMapController cont = await _controller.future;
              controller.getCurrentLocation().then((value){

                cont.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(value.latitude,value.longitude),zoom: 14 )));

              });
            },
            // markers: Set<Marker>.of(controller.state.markers),
          );
        }),
      ),
      // floatingActionButton: Padding(
      //   padding: EdgeInsets.only(right: 50.h),
      //   child: FloatingActionButton(
      //     onPressed: () {
      //
      //       controller.getCurrentLocation().then((value) async {
      //         final GoogleMapController cont = await _controller.future;
      //         controller.state.currentLocation.value =
      //             LatLng(value.latitude, value.longitude);
      //         // controller.state.markers.add(Marker(
      //         //   markerId: MarkerId("1"),
      //         //   position: LatLng(value.latitude, value.longitude),
      //         //   infoWindow: InfoWindow(
      //         //     title: "My Location",
      //         //   ),
      //         // ),);
      //         cont.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: controller.state.currentLocation.value,zoom: 14 )));
      //       }).onError((error, stackTrace) {});
      //     },
      //     child: Icon(Icons.location_on_outlined),
      //   ),
      // ),
    );
  }
}
