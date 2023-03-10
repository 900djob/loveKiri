// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'travelog.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Travelog _$TravelogFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const [
      'id',
      'location_name',
      'adress',
      'lat',
      'lng',
      'description',
      'rate'
    ],
    disallowNullValues: const [
      'id',
      'location_name',
      'adress',
      'lat',
      'lng',
      'description',
      'rate'
    ],
  );
  return Travelog()
    ..id = json['id'] as int
    ..locationName = json['location_name'] as String
    ..adress = json['adress'] as String
    ..lat = (json['lat'] as num).toDouble()
    ..lng = (json['lng'] as num).toDouble()
    ..description = json['description'] as String
    ..rate = json['rate'] as int
    ..imgUrl = json['img_url'] as String?;
}

Map<String, dynamic> _$TravelogToJson(Travelog instance) => <String, dynamic>{
      'id': instance.id,
      'location_name': instance.locationName,
      'adress': instance.adress,
      'lat': instance.lat,
      'lng': instance.lng,
      'description': instance.description,
      'rate': instance.rate,
      'img_url': instance.imgUrl,
    };
