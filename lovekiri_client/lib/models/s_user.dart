import 'package:json_annotation/json_annotation.dart';

part 's_user.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class SUser {
  SUser();

  @JsonKey(required: true, disallowNullValue: true)
  late int userId;

  @JsonKey(name: 'nickname', required: true, disallowNullValue: true)
  late String name;

  @JsonKey(required: true, disallowNullValue: true)
  late String email;

  String? loginType;

  factory SUser.fromJson(Map<String, dynamic> json) => _$SUserFromJson(json);
  Map<String, dynamic> toJson() => _$SUserToJson(this);
}
