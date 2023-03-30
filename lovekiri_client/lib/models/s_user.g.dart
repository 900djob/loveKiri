// GENERATED CODE - DO NOT MODIFY BY HAND

part of 's_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SUser _$SUserFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['login_type', 'name', 'email'],
    disallowNullValues: const ['login_type', 'name', 'email'],
  );
  return SUser()
    ..loginType = json['login_type'] as String
    ..name = json['name'] as String
    ..email = json['email'] as String
    ..travelogs = (json['travelogs'] as List<dynamic>?)
            ?.map((e) => Travelog.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [];
}

Map<String, dynamic> _$SUserToJson(SUser instance) => <String, dynamic>{
      'login_type': instance.loginType,
      'name': instance.name,
      'email': instance.email,
      'travelogs': instance.travelogs.map((e) => e.toJson()).toList(),
    };
