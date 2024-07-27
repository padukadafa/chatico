// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MessageImpl _$$MessageImplFromJson(Map<String, dynamic> json) =>
    _$MessageImpl(
      roomId: json['roomId'] as String?,
      message: json['message'] as String?,
      createdAt: _$JsonConverterFromJson<int, DateTime>(
          json['createdAt'], const EpochDateTimeConverter().fromJson),
      sender: json['sender'] as String?,
      image: json['image'] as String?,
      file: json['file'] as String?,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$$MessageImplToJson(_$MessageImpl instance) =>
    <String, dynamic>{
      'roomId': instance.roomId,
      'message': instance.message,
      'createdAt': _$JsonConverterToJson<int, DateTime>(
          instance.createdAt, const EpochDateTimeConverter().toJson),
      'sender': instance.sender,
      'image': instance.image,
      'file': instance.file,
      'id': instance.id,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
