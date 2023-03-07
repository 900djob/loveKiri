import 'package:lovekiri_client/apis/api.dart';
import 'package:lovekiri_client/models/s_user.dart';

class ApiUser extends Api {
  static Future<SResponse<SUser>> postUser({
    required String type,
    required String name,
    required String email,
    required String ssoId,
    String? lastName,
    String? firstName,
    String? image,
    bool isVerboseLog = false,
  }) {
    Map<String, dynamic> params = {};
    params["type"] = type;
    params["name"] = name;
    params["email"] = email;
    params["ssoId"] = ssoId;
    if (lastName != null) params["lastName"] = lastName;
    if (firstName != null) params["firstName"] = firstName;
    if (image != null) params["image"] = image;

    return Api.post(
      api: '/users/auth',
      parser: (user) => SUser.fromJson(user),
      params: params,
      isVerboseLog: isVerboseLog,
    );
  }
}
