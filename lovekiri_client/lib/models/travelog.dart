import 'package:json_annotation/json_annotation.dart';

part 'travelog.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Travelog {
  Travelog();

  @JsonKey(required: true, disallowNullValue: true)
  late String locationName;

  @JsonKey(required: true, disallowNullValue: true)
  late String address;

  @JsonKey(required: true, disallowNullValue: true)
  late double lat;

  @JsonKey(required: true, disallowNullValue: true)
  late double lng;
  
  @JsonKey(required: true, disallowNullValue: true)
  late String category;

  @JsonKey(required: true, disallowNullValue: true)
  late double dateTime;

  @JsonKey(required: true, disallowNullValue: true)
  late int rate;
  
  @JsonKey(required: true, disallowNullValue: true)
  late String description;

  String? imgUrl;

  factory Travelog.fromJson(Map<String, dynamic> json) => _$TravelogFromJson(json);
  Map<String, dynamic> toJson() => _$TravelogToJson(this);
}
