// GENERATED CODE - DO NOT MODIFY BY HAND

part of 's_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SUser _$SUserFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['id', 'nickname', 'email'],
    disallowNullValues: const ['id', 'nickname', 'email'],
  );
  return SUser()
    ..id = json['id'] as int
    ..name = json['nickname'] as String
    ..email = json['email'] as String
    ..loginType = json['login_type'] as String?;
}

Map<String, dynamic> _$SUserToJson(SUser instance) => <String, dynamic>{
      'id': instance.id,
      'nickname': instance.name,
      'email': instance.email,
      'login_type': instance.loginType,
    };
