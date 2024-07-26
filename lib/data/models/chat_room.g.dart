// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatRoomImpl _$$ChatRoomImplFromJson(Map<String, dynamic> json) =>
    _$ChatRoomImpl(
      roomId: json['roomId'] as String?,
      users: json['users'] == null
          ? const []
          : const UserModelConverter().fromJson(json['users'] as List),
      lastMessage: json['lastMessage'] == null
          ? null
          : Message.fromJson(json['lastMessage'] as Map<String, dynamic>),
      unreadedMessage: (json['unreadedMessage'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$ChatRoomImplToJson(_$ChatRoomImpl instance) =>
    <String, dynamic>{
      'roomId': instance.roomId,
      'users': const UserModelConverter().toJson(instance.users),
      'lastMessage': instance.lastMessage,
      'unreadedMessage': instance.unreadedMessage,
    };
