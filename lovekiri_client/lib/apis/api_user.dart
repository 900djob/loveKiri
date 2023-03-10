import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lovekiri_client/models/s_user.dart';

class ApiUser {
  static final dio = Dio();
  static String apiServer = 'http://localhost:4000';

  static postUser({
    required String loginType,
    required String name,
    required String email,
    required String ssoId,
    String? image,
  }) async {
    Map<String, dynamic> params = {};
    params["login_type"] = loginType;
    params["name"] = name;
    params["email"] = email;
    params["sso_id"] = ssoId;
    if (image != null) params["image"] = image;
    try {
      Response response = await dio.post(
        '$apiServer/users/auth',
        data: params,
      );
      if (response.statusCode == 200) {
        return SUser.fromJson(response.data['user']);
      }
    } catch (e) {
      debugPrint('err: $e');
    }
  }
}
