import 'dart:convert';
import 'dart:io';

import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:chatico/common/services/upload_service.dart';
import 'package:chatico/data/data_sources/user_remote_data_source.dart';
import 'package:chatico/data/models/chat_room.dart';
import 'package:chatico/data/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:uuid/v4.dart';

class ChatRemoteDataSource {
  final _storage = FirebaseStorage.instance.ref();
  final _firestore = FirebaseFirestore.instance;
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
    ChatRoom? chatRoom = await getChatRoomById(roomId);
    if (chatRoom == null) {
      final firstUser =
          await UserRemoteDataSource().getUser(roomId.split("&")[0]);
      final secondUser =
          await UserRemoteDataSource().getUser(roomId.split("&")[1]);
      if (secondUser == null || firstUser == null) {
        return;
      }
      chatRoom = ChatRoom(
        roomId: roomId,
        users: [
          firstUser,
          secondUser,
        ],
      );

      await createChatRoom(chatRoom);
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
      sender: _auth.currentUser?.uid,
      message: message,
      id: messageId,
    );
    await messageRef.update(msg.toJson());
    await updateChatRoom(chatRoom, msg);
  }

  Stream<List<ChatRoom>> getChatRooms() async* {
    final uid = _auth.currentUser?.uid;
    while (true) {
      await 1.seconds.future();
      final response = await _firestore
          .collection('chatRooms')
          .where('user_uids', arrayContains: uid)
          .get();
      if (response.docs.isEmpty) {
        yield [];
      } else {
        yield response.docs.map((e) => ChatRoom.fromJson(e.data())).toList();
      }
    }
  }

  Future<void> createChatRoom(ChatRoom chatRoom) async {
    Map<String, dynamic> newChatRoom = chatRoom.toJson();
    newChatRoom['user_uids'] = [chatRoom.users[0].uid, chatRoom.users[1].uid];

    await _firestore.collection('chatRooms').doc(chatRoom.roomId).set(
          newChatRoom,
          SetOptions(merge: true),
        );
  }

  Future<void> updateChatRoom(
    ChatRoom chatRoom,
    Message msg,
  ) async {
    await _firestore.collection('chatRooms').doc(chatRoom.roomId).set(
      {
        'unreadedMessage': chatRoom.unreadedMessage + 1,
        'lastMessage': msg.toJson(),
      },
      SetOptions(merge: true),
    );
  }

  Future<ChatRoom?> getChatRoomById(String id) async {
    final response = await _firestore.collection("chatRooms").doc(id).get();
    if (response.exists) {
      return ChatRoom.fromJson(response.data()!);
    }
    return null;
  }

  Future<void> deleteMessage(String roomId, String messageId) async {
    final messageRef =
        FirebaseDatabase.instance.ref("chatRooms/$roomId/messages/$messageId");
    await messageRef.remove();
  }

  Future<void> resetUnreadedMessage(ChatRoom chatRoom) async {
    final uid = _auth.currentUser?.uid;
    if (chatRoom.lastMessage?.sender == uid) {
      return;
    }
    await _firestore.collection('chatRooms').doc(chatRoom.roomId).set(
      {
        'unreadedMessage': 0,
      },
      SetOptions(merge: true),
    );
  }
}
