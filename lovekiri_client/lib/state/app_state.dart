import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lovekiri_client/models/s_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AuthStatus {
  none,
  loggedIn,
  loggedOut,
}

class AppState extends GetxController {
  AuthStatus status = AuthStatus.none;

  late SharedPreferences _prefs;
  SharedPreferences get prefs => _prefs;

  late LatLng _currentLocation;
  LatLng get currentLocation => _currentLocation;

  late SUser _user;
  SUser get user => _user;

  @override
  void onInit() {
    _getPrefs();
    _gerCurrentLocation();
    super.onInit();
  }

  Future<void> _getPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    update();
  }

  Future<void> _gerCurrentLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      _currentLocation = LatLng(position.latitude, position.longitude);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
