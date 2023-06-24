import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lovekiri_client/state/app_state.dart';

class MakeTravelogController extends GetxController {
  MakeTravelogController();

  GoogleMapController? mapController;
  LatLng get currentLocation => Get.find<AppState>().currentLocation;

  late LatLng location;
  String? title;
  String? category;
  DateTime? date;
  int? rate;
  String? description;

  Future<void> addLocation() async {}
}
