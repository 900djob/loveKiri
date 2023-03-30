import 'package:get/get.dart';
import 'package:lovekiri_client/apis/api_user.dart';
import 'package:lovekiri_client/models/s_user.dart';
import 'package:lovekiri_client/state/app_state.dart';

class HomeController extends GetxController {
  late SUser user;

  @override
  void onInit() {
    getUser();
    super.onInit();
  }

  Future<void> getUser() async {
    final ssoId = Get.find<AppState>().prefs.getString('accessToken');
    if (ssoId != null) {
      final response = await ApiUser.getUser(ssoId: ssoId);
      if (response is SUser) {
        user = response;
        update();
      }
    }
  }
}