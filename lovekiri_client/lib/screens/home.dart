import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lovekiri_client/screens/controllers/home_c.dart';
import 'package:lovekiri_client/screens/controllers/make_travelog_c.dart';
import 'package:lovekiri_client/screens/make_travelog.dart';
import 'package:lovekiri_client/screens/profile.dart';
import 'package:lovekiri_client/widgets/bottom_navbar.dart';
import 'package:lovekiri_client/widgets/travel_log_tile.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return GetBuilder<HomeController>(
      builder: (_) => Scaffold(
        backgroundColor: const Color(0xfff9f9f9),
        body: SafeArea(
          top: false,
          bottom: false,
          child: Column(
            children: [
              _homeHeader(),
              const SizedBox(height: 32),
              Expanded(
                child: ListView.builder(
                  primary: true,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: 5,
                  itemBuilder: (context, index) => TravelogTile(
                    date: DateTime.now(),
                    title: 'Test Location',
                    locationName: '대구시 북구 대현남로 28',
                    type: '카페',
                    rate: 3,
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavbar(
          context: context,
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
                // transition: Transition.noTransition,
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
            tr('home.홈'),
            style: const TextStyle(
              fontSize: 28,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => Get.to(
              () => MakeTravelog(),
              binding: BindingsBuilder(() {
                Get.put(MakeTravelogController());
              }),
              // transition: Transition.noTransition,
            ),
            child: SvgPicture.asset("assets/svgs/add_btn.svg", color: Colors.black, width: 22),
          ),
        ],
      ),
    );
  }
}
