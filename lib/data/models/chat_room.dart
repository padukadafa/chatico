import 'package:chatico/data/models/message.dart';
import 'package:chatico/data/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_room.freezed.dart';
part 'chat_room.g.dart';

@freezed
class ChatRoom with _$ChatRoom {
  const factory ChatRoom({
    String? roomId,
    @UserModelConverter() @Default([]) List<UserModel> users,
    Message? lastMessage,
    @Default(0) int unreadedMessage,
  }) = _ChatRoom;

  factory ChatRoom.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomFromJson(json);
}

class UserModelConverter
    implements JsonConverter<List<UserModel>, Map<dynamic, dynamic>> {
  const UserModelConverter();

  @override
  List<UserModel> fromJson(Map<dynamic, dynamic>? json) {
    if (json == null) {
      return [];
    }
    return json.values
        .map((e) => UserModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  @override
  Map<dynamic, dynamic> toJson(List<UserModel> object) {
    return Map.fromIterable(
      object.map((e) => e.toJson()),
      key: (element) => element['uid'],
    );
  }
}

@Collection<ChatRoom>('chatRooms')
final chatRoomRef = ChatRoomCollectionReference();
