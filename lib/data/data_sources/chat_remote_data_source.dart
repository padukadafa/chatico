import 'dart:convert';
import 'dart:io';

import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:chatico/services/notification_service.dart';
import 'package:chatico/services/upload_service.dart';

import 'package:chatico/common/utils/utils.dart';
import 'package:chatico/data/data_sources/user_remote_data_source.dart';
import 'package:chatico/data/models/chat_room.dart';
import 'package:chatico/data/models/message.dart';
import 'package:chatico/data/models/notification.dart';
import 'package:chatico/data/models/user.dart';
import 'package:chatico/di.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart';
import 'package:uuid/v4.dart';

@injectable
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

  Future<void> sendMessage(ChatRoom chatRoom,
      {String? message, File? image, File? file}) async {
    if (message?.isEmpty ?? true) {
      return;
    }
    final uploadService = UploadService(_storage);
    final messageId = const UuidV4().generate();
    final roomId = chatRoom.roomId!;
    final messageRef =
        FirebaseDatabase.instance.ref("chatRooms/$roomId/messages/$messageId");
    if (chatRoom.users.length < 2) {
      final firstUser =
          await getIt<UserRemoteDataSource>().getUser(roomId.split("&")[0]);
      final secondUser =
          await getIt<UserRemoteDataSource>().getUser(roomId.split("&")[1]);
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
    final intercolutor = Utils.getIntercolutor(chatRoom.users);
    await updateChatRoom(chatRoom, msg);
    await messageRef.update(msg.toJson());

    await NotificationService.sendNotification(
      NotificationModel(
        body: msg.message,
        createdAt: DateTime.now().toIso8601String(),
        senderUid: _auth.currentUser?.uid,
        roomId: roomId,
        summary: "New Message",
        target: intercolutor.fcmToken,
        receiver: intercolutor.uid,
        title: _auth.currentUser?.displayName,
      ),
    );
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
    await _firestore.collection('chatRooms').doc(chatRoom.roomId).update(
      {
        'unreadedMessage': FieldValue.increment(1),
        'lastMessage': msg.toJson(),
      },
    );
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

  Future<void> updateFcmToken(ChatRoom chatRoom) async {
    if (chatRoom.users.length < 2) {
      return;
    }
    final fcmToken = await FirebaseMessaging.instance.getToken();
    final uid = _auth.currentUser?.uid;
    final currentUser = chatRoom.users.firstWhere((e) => e.uid == uid);
    if (currentUser.fcmToken != fcmToken) {
      List<UserModel> newUsers = chatRoom.users.toList();
      newUsers.removeWhere((e) => e.uid == uid);
      newUsers.add(currentUser.copyWith(fcmToken: fcmToken));
      chatRoomRef.doc(chatRoom.roomId).update(users: newUsers);
    }
  }
}
