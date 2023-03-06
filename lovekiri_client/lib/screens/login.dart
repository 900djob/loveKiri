import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lovekiri_client/apis/api_user.dart';
import 'package:lovekiri_client/screens/home.dart';
import 'package:lovekiri_client/utils/util_login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
  }

  Future<bool> _socialLogin(LoginInfo info) async {
    final response = await ApiUser.postUser(
      type: info.loginType,
      name: info.name,
      email: info.email,
      ssoId: info.ssoId,
    );
    if (response.isSuccess) {
      return true;
    }
    return false;
  }

  Future<void> googleLogin() async {
    final userData = await UtilLogin.signInWithGoogle();
    final user = userData.user;

    if (user != null) {
      final validationResult = await ApiUser.postUserValidation(
        email: user.email!,
      );
      if (validationResult.isSuccess) {
        Get.to(
          const HomeScreen(),
          transition: Transition.noTransition,
        );
        return;
      }

      final registerResult = await ApiUser.postUser(
        type: 'google',
        name: user.displayName!,
        email: user.email!,
        ssoId: user.uid,
      );
      if (registerResult.isSuccess) {
        Get.to(
          const HomeScreen(),
          transition: Transition.noTransition,
        );
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      googleLogin();
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
                  const SizedBox(width: 32),
                  GestureDetector(
                    onTap: () async {
                      final kakaoUser = await UtilLogin.loginKakao();
                      if (kakaoUser != null) {
                        final isLogin = await _socialLogin(kakaoUser);
                        if (isLogin) {
                          Get.to(const HomeScreen());
                        }
                      }
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
