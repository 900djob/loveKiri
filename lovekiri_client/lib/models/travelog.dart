import 'package:json_annotation/json_annotation.dart';

part 'travelog.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Travelog {
  Travelog();

  @JsonKey(required: true, disallowNullValue: true)
  late int id;

  @JsonKey(required: true, disallowNullValue: true)
  late String locationName;

  @JsonKey(required: true, disallowNullValue: true)
  late String adress;

  @JsonKey(required: true, disallowNullValue: true)
  late double lat;

  @JsonKey(required: true, disallowNullValue: true)
  late double lng;

  @JsonKey(required: true, disallowNullValue: true)
  late String description;

  @JsonKey(required: true, disallowNullValue: true)
  late int rate;

  String? imgUrl;

  factory Travelog.fromJson(Map<String, dynamic> json) => _$TravelogFromJson(json);
  Map<String, dynamic> toJson() => _$TravelogToJson(this);
}

//id
//dayDate
//locationName
//adress
//lat
//lng
//description
//rate
//imgUrl

