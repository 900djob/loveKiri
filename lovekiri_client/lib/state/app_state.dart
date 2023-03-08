import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AuthStatus {
  notDetermined,
  loggedIn,
  loggedOut,
}

class AppState extends GetxController {
  AuthStatus status = AuthStatus.notDetermined;
  late SharedPreferences _prefs;
  SharedPreferences get prefs => _prefs;

  @override
  void onInit() {
    getPrefs();
    super.onInit();
  }

  Future<void> getPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    update();
  }
}
