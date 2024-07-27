// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      uid: json['uid'] as String,
      name: json['name'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      avatar: json['avatar'] as String?,
      fcmToken: json['fcmToken'] as String?,
    );

const _$$UserModelImplFieldMap = <String, String>{
  'uid': 'uid',
  'name': 'name',
  'phoneNumber': 'phoneNumber',
  'avatar': 'avatar',
  'fcmToken': 'fcmToken',
};

// ignore: unused_element
abstract class _$$UserModelImplPerFieldToJson {
  // ignore: unused_element
  static Object? uid(String instance) => instance;
  // ignore: unused_element
  static Object? name(String? instance) => instance;
  // ignore: unused_element
  static Object? phoneNumber(String? instance) => instance;
  // ignore: unused_element
  static Object? avatar(String? instance) => instance;
  // ignore: unused_element
  static Object? fcmToken(String? instance) => instance;
}

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'avatar': instance.avatar,
      'fcmToken': instance.fcmToken,
    };
