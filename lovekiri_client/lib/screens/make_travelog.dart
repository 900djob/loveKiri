import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lovekiri_client/screens/controllers/make_travelog_c.dart';
import 'package:lovekiri_client/screens/profile.dart';
import 'package:lovekiri_client/state/app_state.dart';
import 'package:lovekiri_client/widgets/calendar_bottomsheet.dart';
import 'package:lovekiri_client/widgets/select_bottomsheet.dart';

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
                          const SizedBox(height: 24),
                          _getCategory(),
                          const SizedBox(height: 24),
                          _getDate(),
                          const SizedBox(height: 24),
                          _getRate(),
                          const SizedBox(height: 24),
                          _getDescription(),
                          const SizedBox(height: 32),
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
            tr('travelog.장소'),
            style: const TextStyle(
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 2,
                  blurRadius: 24,
                ),
              ],
              color: const Color(0xffffffff),
            ),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: tr('travelog.장소.hint'),
                hintStyle: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFFC5C5C7),
                  fontWeight: FontWeight.normal,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                suffixIcon: const Icon(
                  Icons.search,
                  color: Colors.black,
                  size: 28,
                ),
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.zero),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.zero),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (v) {},
            ),
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              width: double.infinity,
              height: 220,
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
          ),
        ],
      ),
    );
  }

  Widget _getCategory() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tr('travelog.카테고리'),
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
              decoration: InputDecoration(
                hintText: tr('travelog.카테고리.hint'),
                hintStyle: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFFC5C5C7),
                  fontWeight: FontWeight.normal,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.zero),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.zero),
                  borderSide: BorderSide.none,
                ),
              ),
              readOnly: true,
              controller: TextEditingController(text: c.category),
              onTap: () async {
                final category = await Get.bottomSheet<String>(
                  const SelectBottomSheet(
                    title: 'Category',
                    data: [
                      'aaaa',
                      'bbbb',
                      'cccc',
                      'dddd',
                      'eeee',
                      'ffff',
                      'gggg',
                      'hhhh',
                      'iiii'
                    ],
                  ),
                );
                if (category != null) {
                  c.category = category;
                  c.update();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  // Widget _getTitle() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 24),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           tr('travelog.제목'),
  //           style: const TextStyle(
  //             fontSize: 22,
  //           ),
  //         ),
  //         const SizedBox(height: 8),
  //         Container(
  //           decoration: BoxDecoration(
  //             color: Colors.white,
  //             borderRadius: BorderRadius.circular(8.0),
  //             boxShadow: const [
  //               BoxShadow(
  //                 color: Colors.black12,
  //                 spreadRadius: 2,
  //                 blurRadius: 24,
  //               ),
  //             ],
  //           ),
  //           child: TextFormField(
  //             decoration: InputDecoration(
  //               hintText: tr('travelog.제목.hint'),
  //               hintStyle: const TextStyle(
  //                 fontSize: 16,
  //                 color: Color(0xFFC5C5C7),
  //                 fontWeight: FontWeight.normal,
  //               ),
  //               contentPadding: const EdgeInsets.symmetric(horizontal: 8),
  //               enabledBorder: const OutlineInputBorder(
  //                 borderRadius: BorderRadius.all(Radius.zero),
  //                 borderSide: BorderSide.none,
  //               ),
  //               focusedBorder: const OutlineInputBorder(
  //                 borderRadius: BorderRadius.all(Radius.zero),
  //                 borderSide: BorderSide.none,
  //               ),
  //             ),
  //             maxLines: 1,
  //             onChanged: (v) {
  //               c.title = v;
  //               c.update();
  //             },
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _getDate() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tr('travelog.날짜'),
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
              decoration: InputDecoration(
                hintText: tr('travelog.날짜.hint'),
                hintStyle: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFFC5C5C7),
                  fontWeight: FontWeight.normal,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.zero),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.zero),
                  borderSide: BorderSide.none,
                ),
              ),
              maxLines: 1,
              readOnly: true,
              controller: TextEditingController(text: c.date != null ? DateFormat.yMEd().format(c.date!) : ""),
              onTap: () async {
                final selectedDate = await Get.bottomSheet<DateTime>(
                  const CalendarBottomSheet(),
                );
                if (selectedDate != null) {
                  c.date = selectedDate;
                  c.update();
                }
              },
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
            tr('travelog.평점'),
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
              decoration: InputDecoration(
                hintText: tr('travelog.평점.hint'),
                hintStyle: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFFC5C5C7),
                  fontWeight: FontWeight.normal,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.zero),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: const OutlineInputBorder(
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
            tr('travelog.설명'),
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
              decoration: InputDecoration(
                hintText: tr('travelog.설명.hint'),
                hintStyle: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFFC5C5C7),
                  fontWeight: FontWeight.normal,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.zero),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.zero),
                  borderSide: BorderSide.none,
                ),
              ),
              maxLines: 10,
              onChanged: (v) {
                c.description = v;
                c.update();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _addBtn() {
    return GestureDetector(
      onTap: () => c.addLocation(),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 52, left: 24, right: 24),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 6),
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
            tr('trvelog.등록'),
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 22, color: Color(0xfff9f9f9)),
          ),
        ),
      ),
    );
  }
}
