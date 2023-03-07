import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class LoginInfo {
  final String loginType;
  final String name;
  final String email;
  final String ssoId;
  final String? imgUrl;
  LoginInfo(this.loginType, this.name, this.email, this.ssoId, this.imgUrl);
}

class UtilLogin {
  static Future<LoginInfo?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      final userData = await FirebaseAuth.instance.signInWithCredential(credential);
      final user = userData.user!;
      return LoginInfo(
        'google',
        user.displayName!,
        user.email!,
        user.uid,
        user.photoURL,
      );
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  static Future<LoginInfo?> signInWithKakao() async {
    try {
      final installed = await isKakaoTalkInstalled();
      installed ? await UserApi.instance.loginWithKakaoTalk() : await UserApi.instance.loginWithKakaoAccount();
      final me = await UserApi.instance.me();
      return LoginInfo(
        'kakao',
        me.properties!.values.elementAt(0),
        me.kakaoAccount!.email!,
        '${me.id}',
        me.properties!.values.elementAt(1),
      );
    } on KakaoAuthException catch (e) {
      debugPrint(e.toString());
    } on KakaoClientException catch (e) {
      debugPrint(e.toString());
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }
}
