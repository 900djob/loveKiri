import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lovekiri_client/screens/profile.dart';
import 'package:lovekiri_client/state/app_state.dart';
import 'package:lovekiri_client/widgets/bottom_navbar.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final _currentLocation = Get.find<AppState>().currentLocation;

  GoogleMapController? mapController;
  List<Marker> _markers = [];

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
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 100),
                  initialCameraPosition: CameraPosition(
                    target: _currentLocation,
                    zoom: 14,
                  ),
                  onMapCreated: (controller) {
                    setState(() {
                      mapController = controller;
                      mapController?.animateCamera(
                        CameraUpdate.newCameraPosition(
                          CameraPosition(
                            target: LatLng(
                              _currentLocation.latitude,
                              _currentLocation.longitude,
                            ),
                            zoom: 14,
                          ),
                        ),
                      );
                    });
                  },
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  rotateGesturesEnabled: false,
                  tiltGesturesEnabled: false,
                  markers: Set.from(_markers),
                  // onTap: _setMarker,
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
          GestureDetector(
            onTap: () {
              Get.to(
                () => const ProfileScreen(),
                transition: Transition.noTransition,
              );
            },
            child: Container(
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

  void _setMarker(LatLng tapPoint) async {
    setState(() {
      if (_markers.isNotEmpty) {
        _markers.clear();
        return;
      }
      _markers.clear();
      _markers.add(Marker(
        markerId: MarkerId(tapPoint.toString()),
        position: tapPoint,
      ));
    });
  }
}
