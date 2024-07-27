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

const _$$MessageImplFieldMap = <String, String>{
  'roomId': 'roomId',
  'message': 'message',
  'createdAt': 'createdAt',
  'sender': 'sender',
  'image': 'image',
  'file': 'file',
  'id': 'id',
};

// ignore: unused_element
abstract class _$$MessageImplPerFieldToJson {
  // ignore: unused_element
  static Object? roomId(String? instance) => instance;
  // ignore: unused_element
  static Object? message(String? instance) => instance;
  // ignore: unused_element
  static Object? createdAt(DateTime? instance) =>
      _$JsonConverterToJson<int, DateTime>(
          instance, const EpochDateTimeConverter().toJson);
  // ignore: unused_element
  static Object? sender(String? instance) => instance;
  // ignore: unused_element
  static Object? image(String? instance) => instance;
  // ignore: unused_element
  static Object? file(String? instance) => instance;
  // ignore: unused_element
  static Object? id(String? instance) => instance;
}

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
