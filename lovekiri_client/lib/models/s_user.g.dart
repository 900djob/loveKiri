// GENERATED CODE - DO NOT MODIFY BY HAND

part of 's_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SUser _$SUserFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['user_id', 'name', 'email'],
    disallowNullValues: const ['user_id', 'name', 'email'],
  );
  return SUser()
    ..loginType = json['login_type'] as String?
    ..userId = json['user_id'] as int
    ..name = json['name'] as String
    ..email = json['email'] as String;
}

Map<String, dynamic> _$SUserToJson(SUser instance) => <String, dynamic>{
      'login_type': instance.loginType,
      'user_id': instance.userId,
      'name': instance.name,
      'email': instance.email,
    };
