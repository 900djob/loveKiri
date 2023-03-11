import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lovekiri_client/screens/login.dart';
import 'package:lovekiri_client/state/app_state.dart';

import '../widgets/bottom_navbar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final appStatus = Get.find<AppState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: Column(
          children: [
            _mapHeader(),
            const SizedBox(height: 32),
            GestureDetector(
              onTap: () => signOut(),
              child: Container(
                color: Colors.transparent,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                child: const Text('logout'),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavbar(context: context),
    );
  }

  Widget _mapHeader() {
    return Padding(
      padding: const EdgeInsets.only(top: 64, left: 24, right: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
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
          const SizedBox(width: 24),
          Text(
            tr('profile.프로필'),
            style: const TextStyle(
              fontSize: 28,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    appStatus.prefs.remove('accessToken');
    appStatus.status = AuthStatus.loggedOut;
    Get.to(
      () => const LoginScreen(),
      transition: Transition.noTransition,
    );
  }
}
