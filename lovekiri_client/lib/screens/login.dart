import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lovekiri_client/apis/api_user.dart';
import 'package:lovekiri_client/screens/home.dart';
import 'package:lovekiri_client/state/app_state.dart';
import 'package:lovekiri_client/utils/util_login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final appState = Get.find<AppState>();

  Future<void> socialLogin(String type) async {
    LoginInfo? userData;
    if (type == 'google') {
      userData = await UtilLogin.signInWithGoogle();
    }
    if (type == 'kakao') {
      userData = await UtilLogin.signInWithKakao();
    }

    if (userData != null) {
      final response = await ApiUser.postUser(
        loginType: userData.loginType,
        name: userData.name,
        email: userData.email,
        ssoId: userData.ssoId,
      );
      if (response.isSuccess) {
        appState.prefs.setBool('isRegistered', true);
        appState.prefs.setString('accessToken', userData.ssoId);
        Get.offAll(
          () => const HomeScreen(),
          transition: Transition.noTransition,
        );
        return;
      }
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    final isRegistered = appState.prefs.getBool('isRegistered') == true;
    final hasAccessToken = appState.prefs.getString('accessToken') != null;
    if (isRegistered && hasAccessToken) {
      appState.status = AuthStatus.loggedIn;
      return const HomeScreen();
    }
    return Scaffold(
      backgroundColor: const Color(0xfff9f9f9),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 128),
              Text(
                tr('login.loveKiri'),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 52,
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      socialLogin('google');
                    },
                    child: Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.transparent),
                      child: SvgPicture.asset(
                        'assets/svgs/google_logo.svg',
                        width: 32,
                      ),
                    ),
                  ),
                  const SizedBox(width: 38),
                  GestureDetector(
                    onTap: () async {
                      socialLogin('kakao');
                    },
                    child: Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.transparent),
                      child: SvgPicture.asset(
                        'assets/svgs/kakao_logo.svg',
                        width: 32,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 128),
            ],
          ),
        ),
      ),
    );
  }
}
