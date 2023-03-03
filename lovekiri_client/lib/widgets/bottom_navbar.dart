import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lovekiri_client/screens/home.dart';
import 'package:lovekiri_client/screens/map.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({
    Key? key,
    required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 32),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        width: screenSize.width,
        decoration: const BoxDecoration(
          color: Color(0xffffffff),
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 6,
              blurRadius: 8,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () => Get.to(
                () => const HomeScreen(),
                transition: Transition.noTransition,
              ),
              child: Container(
                color: Colors.transparent,
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                child: SvgPicture.asset('assets/svgs/nav_home_inactive.svg'),
              ),
            ),
            GestureDetector(
              onTap: () => Get.to(
                () => const MapScreen(),
                transition: Transition.noTransition,
              ),
              child: Container(
                color: Colors.transparent,
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                child: SvgPicture.asset('assets/svgs/nav_map_inactive.svg'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
