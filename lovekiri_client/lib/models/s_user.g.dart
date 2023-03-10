// GENERATED CODE - DO NOT MODIFY BY HAND

part of 's_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SUser _$SUserFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['user_id', 'nickname', 'email'],
    disallowNullValues: const ['user_id', 'nickname', 'email'],
  );
  return SUser()
    ..userId = json['user_id'] as int
    ..name = json['nickname'] as String
    ..email = json['email'] as String
    ..loginType = json['login_type'] as String?;
}

Map<String, dynamic> _$SUserToJson(SUser instance) => <String, dynamic>{
      'user_id': instance.userId,
      'nickname': instance.name,
      'email': instance.email,
      'login_type': instance.loginType,
    };
