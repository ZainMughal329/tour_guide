import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'controller.dart';

class MapPage extends GetView<MapController> {
  const MapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: controller.cameraPosition,
        markers: Set<Marker>.of(controller.marker),
        onMapCreated: (con) {
          controller.completer.complete(con);
        },
        // myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          controller.getUserLocation().then((value) async{
            print('Latitude is :' + value.latitude.toString());

            controller.marker.add(Marker(
                markerId: MarkerId('1'),
                position: LatLng(value.latitude , value.longitude),
                icon: BitmapDescriptor.defaultMarker),);
            CameraPosition cameraPosition = CameraPosition(target: LatLng(value.latitude , value.longitude) , zoom: 14);
            GoogleMapController mapController = await controller.completer.future;
            mapController.animateCamera(
              CameraUpdate.newCameraPosition(cameraPosition),
            );
          });
        },
        child: Icon(Icons.my_location),
      ),
    );
  }
}
