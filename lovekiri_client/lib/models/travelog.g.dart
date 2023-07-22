// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'travelog.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Travelog _$TravelogFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const [
      'location_name',
      'address',
      'lat',
      'lng',
      'category',
      'date_time',
      'rate',
      'description'
    ],
    disallowNullValues: const [
      'location_name',
      'address',
      'lat',
      'lng',
      'category',
      'date_time',
      'rate',
      'description'
    ],
  );
  return Travelog()
    ..locationName = json['location_name'] as String
    ..address = json['address'] as String
    ..lat = (json['lat'] as num).toDouble()
    ..lng = (json['lng'] as num).toDouble()
    ..category = json['category'] as String
    ..dateTime = (json['date_time'] as num).toDouble()
    ..rate = json['rate'] as int
    ..description = json['description'] as String
    ..imgUrl = json['img_url'] as String?;
}

Map<String, dynamic> _$TravelogToJson(Travelog instance) => <String, dynamic>{
      'location_name': instance.locationName,
      'address': instance.address,
      'lat': instance.lat,
      'lng': instance.lng,
      'category': instance.category,
      'date_time': instance.dateTime,
      'rate': instance.rate,
      'description': instance.description,
      'img_url': instance.imgUrl,
    };
