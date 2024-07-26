import 'package:chatico/data/models/message.dart';
import 'package:chatico/data/models/user.dart';
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
    implements JsonConverter<List<UserModel>, List<dynamic>> {
  const UserModelConverter();

  @override
  List<UserModel> fromJson(List<dynamic> json) {
    return json
        .map((e) => UserModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  @override
  List<Map<String, dynamic>> toJson(List<UserModel> object) {
    return object.map((e) => e.toJson()).toList();
  }
}
