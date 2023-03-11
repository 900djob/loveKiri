import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lovekiri_client/models/travelog.dart';
import 'package:lovekiri_client/screens/profile.dart';
import 'package:lovekiri_client/widgets/bottom_navbar.dart';

class TestLog {
  final String locationName;
  final String adress;
  final DateTime dateTime;
  final double lat;
  final double lng;
  final String description;
  final int rate;
  final String? imgUrl;

  TestLog(
    this.locationName,
    this.adress,
    this.dateTime,
    this.lat,
    this.lng,
    this.description,
    this.rate,
    this.imgUrl,
  );
}

class TravelogDetailScreen extends StatefulWidget {
  const TravelogDetailScreen({
    // required this.travelog,
    super.key,
  });

  // final Travelog travelog;

  @override
  State<TravelogDetailScreen> createState() => _TravelogDetailScreenState();
}

class _TravelogDetailScreenState extends State<TravelogDetailScreen> {
  GoogleMapController? mapController;
  final LatLng _initialPosition = const LatLng(33.2464308, 126.4118265);

  final testTravelog = TestLog(
    "Test Location",
    "대구시 북구 대현남로 28",
    DateTime.now(),
    33.2464308,
    126.4118265,
    "뷰가 좋고 분위기가 좋고 전반적으로 아주 좋음. 뷰가 좋고 분위기가 좋고 전반적으로 아주 좋음.뷰가 좋고 분위기가 좋고 전반적으로 아주 좋음.",
    4,
    null,
  );

  final mapMarkers = <Marker>{};
  LatLng? mapLatLng;

  @override
  void initState() {
    super.initState();

    mapLatLng = LatLng(testTravelog.lat, testTravelog.lng);
    mapMarkers.add(
      Marker(
        markerId: MarkerId('1'),
        position: mapLatLng!,
        infoWindow: InfoWindow(title: testTravelog.locationName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff9f9f9),
      body: SafeArea(
        top: false,
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _detailHeader(),
              const SizedBox(height: 32),
              _getDateTime(),
              const SizedBox(height: 12),
              _getLocation(),
              const SizedBox(height: 32),
              getInfo(testTravelog),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavbar(context: context),
    );
  }

  Widget _getDateTime() {
    return Align(
      alignment: Alignment.topRight,
      child: Text(
        DateFormat.yMEd().format(testTravelog.dateTime),
        style: const TextStyle(
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _detailHeader() {
    return Padding(
      padding: const EdgeInsets.only(top: 64),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
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
                    spreadRadius: 2,
                    blurRadius: 24,
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
          const SizedBox(width: 24),
          Text(
            tr('travelog.트레벨로그'),
            style: const TextStyle(
              fontSize: 28,
            ),
          ),
        ],
      ),
    );
  }

  Widget _getLocation() {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      width: screenSize.width,
      height: screenSize.width * (196.0 / 375.0),
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 2,
            blurRadius: 8,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            target: _initialPosition,
            zoom: 17,
          ),
          onMapCreated: (controller) {
            setState(() {
              mapController = controller;
              mapController?.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: LatLng(
                      _initialPosition.latitude,
                      _initialPosition.longitude,
                    ),
                    zoom: 17,
                  ),
                ),
              );
            });
          },
          markers: Set<Marker>.of(mapMarkers),
          myLocationButtonEnabled: false,
          myLocationEnabled: false,
          rotateGesturesEnabled: false,
          scrollGesturesEnabled: false,
          zoomControlsEnabled: false,
          zoomGesturesEnabled: false,
          tiltGesturesEnabled: false,
        ),
      ),
    );
  }

  Widget getInfo(TestLog info) {
    return Expanded(
      child: SingleChildScrollView(
        primary: true,
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              info.locationName,
              style: const TextStyle(
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 18),
            Text(
              info.description,
            ),
          ],
        ),
      ),
    );
  }
}
