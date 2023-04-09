import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lovekiri_client/screens/controllers/make_travelog_c.dart';
import 'package:lovekiri_client/screens/profile.dart';
import 'package:lovekiri_client/state/app_state.dart';

class MakeTravelog extends StatelessWidget {
  MakeTravelog({super.key});

  final appStatus = Get.find<AppState>();
  final MakeTravelogController c = Get.find<MakeTravelogController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: GetBuilder<MakeTravelogController>(
        builder: (c) => Scaffold(
          body: SafeArea(
            top: false,
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _homeHeader(),
                const SizedBox(height: 40),
                Expanded(
                  child: SizedBox(
                    height: double.infinity,
                    child: SingleChildScrollView(
                      primary: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          _getLocation(),
                          const SizedBox(height: 12),
                          _getTitle(),
                          const SizedBox(height: 12),
                          _getDate(),
                          const SizedBox(height: 12),
                          _getRate(),
                          const SizedBox(height: 12),
                          _getDescription(),
                          const SizedBox(height: 24),
                          _addBtn(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _homeHeader() {
    return Padding(
      padding: const EdgeInsets.only(top: 64, left: 24, right: 24),
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
            tr('travelog.메이크'),
            style: const TextStyle(
              fontSize: 28,
            ),
          ),
        ],
      ),
    );
  }

  Widget _getLocation() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Location",
            style: const TextStyle(
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            height: 220,
            decoration: const BoxDecoration(),
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: c.currentLocation,
                zoom: 14,
              ),
              onMapCreated: (controller) {},
              myLocationButtonEnabled: false,
              myLocationEnabled: true,
              rotateGesturesEnabled: false,
              tiltGesturesEnabled: false,
            ),
          ),
        ],
      ),
    );
  }

  Widget _getTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Title",
            style: const TextStyle(
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 2,
                  blurRadius: 24,
                ),
              ],
            ),
            child: TextFormField(
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 8),
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
              maxLines: 1,
              onSaved: (v) {},
              onChanged: (v) {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _getDate() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Date",
            style: const TextStyle(
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 2,
                  blurRadius: 24,
                ),
              ],
            ),
            child: TextFormField(
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 8),
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
              maxLines: 1,
              onSaved: (v) {},
              onChanged: (v) {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _getRate() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Rate",
            style: const TextStyle(
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 2,
                  blurRadius: 24,
                ),
              ],
            ),
            child: TextFormField(
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
              maxLines: 1,
              onSaved: (v) {},
              onChanged: (v) {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _getDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Description",
            style: const TextStyle(
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 2,
                  blurRadius: 24,
                ),
              ],
            ),
            child: TextFormField(
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
              maxLines: 10,
              onSaved: (v) {},
              onChanged: (v) {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _addBtn() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 52, left: 120, right: 120),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 1,
              blurRadius: 20,
            ),
          ],
        ),
        child: Text(
          'Confirm',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 22,
            color: Color(0xfff9f9f9)
          ),
        ),
      ),
    );
  }
}
