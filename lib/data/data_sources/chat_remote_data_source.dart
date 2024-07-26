import 'dart:convert';
import 'dart:io';

import 'package:chatico/common/services/upload_service.dart';
import 'package:chatico/data/data_sources/user_remote_data_source.dart';
import 'package:chatico/data/models/chat_room.dart';
import 'package:chatico/data/models/message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:uuid/v4.dart';

class ChatRemoteDataSource {
  final _storage = FirebaseStorage.instance.ref();
  final _auth = FirebaseAuth.instance;

  Stream<List<Message>> getMessages(String roomId) {
    final snapshot = FirebaseDatabase.instance
        .ref("chatRooms/$roomId/messages")
        .orderByChild("createdAt");

    return snapshot.onValue.asyncMap<List<Message>>((e) {
      if (e.snapshot.value != null) {
        return e.snapshot.children
            .map((s) {
              final a = s.value as Map;
              return Message.fromJson(Map<String, dynamic>.from(a));
            })
            .toList()
            .reversed
            .toList();
      }
      return [];
    });
  }

  Future<void> sendMessage(String roomId,
      {String? message, File? image, File? file}) async {
    final uploadService = UploadService(_storage);
    final messageId = const UuidV4().generate();
    final messageRef =
        FirebaseDatabase.instance.ref("chatRooms/$roomId/messages/$messageId");
    final roomRef = FirebaseDatabase.instance.ref("chatRooms/$roomId");
    final chatRoom = await roomRef.get();
    if (chatRoom.value == null) {
      final firstUser =
          await UserRemoteDataSource().getUser(roomId.split("&")[0]);
      final secondUser =
          await UserRemoteDataSource().getUser(roomId.split("&")[1]);
      if (secondUser == null || firstUser == null) {
        return;
      }
      await roomRef.set(ChatRoom(
        roomId: roomId,
        users: [
          firstUser,
          secondUser,
        ],
        unreadedMessage: 0,
      ).toJson());
    }
    String? imageLink;
    String? fileLink;
    if (image != null) {
      imageLink = await uploadService.uploadFile(image,
          'chatRooms/$roomId/images/${const UuidV4()}${extension(image.path)}');
    }
    if (file != null) {
      fileLink = await uploadService.uploadFile(file,
          'chatRooms/$roomId/files/${const UuidV4().generate()}${extension(file.path)}');
    }
    final msg = Message(
      roomId: roomId,
      createdAt: DateTime.now(),
      file: fileLink,
      image: imageLink,
      from: _auth.currentUser?.uid,
      message: message,
      id: messageId,
    );
    await messageRef.update(msg.toJson());
    await roomRef.update({
      'lastMessage': msg.toJson(),
      'unreadedMessage': (chatRoom.value as Map)['unreadedMessage'] + 1
    });
  }

  Stream<List<ChatRoom>> getChatRooms() {
    final uid = _auth.currentUser?.uid;
    final snapshot = FirebaseDatabase.instance
        .ref("chatRooms")
        .orderByChild('roomId')
        .startAt(uid)
        .endAt("\uf8ff");
    return snapshot.onValue.asyncMap<List<ChatRoom>>((e) {
      if (e.snapshot.value != null) {
        return e.snapshot.children.map((s) {
          final a = s.value as Map;
          return ChatRoom.fromJson({
            'roomId': a['roomId'],
            'lastMessage': Map<String, dynamic>.from(a['lastMessage']),
            'users': a['users'] ?? [],
          });
        }).toList();
      }
      return [];
    });
  }
}
