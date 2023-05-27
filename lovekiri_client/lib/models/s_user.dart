import 'package:json_annotation/json_annotation.dart';
import 'package:lovekiri_client/models/travelog.dart';

part 's_user.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class SUser {
  SUser();

  @JsonKey(required: true, disallowNullValue: true)
  late String loginType;

  @JsonKey(required: true, disallowNullValue: true)
  late String name;

  @JsonKey(required: true, disallowNullValue: true)
  late String email;

  @JsonKey(defaultValue: [], disallowNullValue: false)
  late List<Travelog> travelogs;

  factory SUser.fromJson(Map<String, dynamic> json) => _$SUserFromJson(json);
  Map<String, dynamic> toJson() => _$SUserToJson(this);
}
