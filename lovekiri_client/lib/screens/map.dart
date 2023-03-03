import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lovekiri_client/widgets/bottom_navbar.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;
  final LatLng _initialPosition = const LatLng(35.88044951993048, 128.6076791139698);

  LatLng? _currentLocation;

  Future<void> _gerCurrentLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      _currentLocation = LatLng(position.latitude, position.longitude);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void initState() {
    _gerCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SafeArea(
        top: false,
        bottom: false,
        child: Container(
          color: const Color(0xfff9f9f9),
          child: Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: GoogleMap(
                  mapType: MapType.normal,
                  padding: const EdgeInsets.only(left: 24),
                  initialCameraPosition: CameraPosition(
                    target: _initialPosition,
                    zoom: 17,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    setState(() {
                      if (_currentLocation != null) {
                        mapController = controller;
                        mapController?.animateCamera(
                          CameraUpdate.newCameraPosition(
                            CameraPosition(
                              target: LatLng(
                                _currentLocation!.latitude,
                                _currentLocation!.longitude,
                              ),
                              zoom: 17,
                            ),
                          ),
                        );
                      }
                    });
                  },
                  myLocationButtonEnabled: false,
                  myLocationEnabled: true,
                  rotateGesturesEnabled: false,
                  tiltGesturesEnabled: false,
                ),
              ),
              _mapHeader(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavbar(context: context),
    );
  }

  Widget _mapHeader() {
    return Padding(
      padding: const EdgeInsets.only(top: 64, left: 24, right: 24),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 6,
                  blurRadius: 8,
                ),
              ],
              color: const Color(0xffffffff),
            ),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
              ),
              child: SvgPicture.asset('assets/svgs/empty_profile.svg'),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 6,
                    blurRadius: 8,
                  ),
                ],
                color: const Color(0xffffffff),
              ),
              child: TextFormField(
                decoration: const InputDecoration(
                  suffixIcon: Icon(
                    Icons.search,
                    color: Colors.black,
                    size: 28,
                  ),
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: Color(0xFFC5C5C7),
                    fontWeight: FontWeight.normal,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.zero),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.zero),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
