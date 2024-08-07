import 'dart:io';

import 'package:chatico/services/upload_service.dart';
import 'package:chatico/data/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart';

@injectable
class UserRemoteDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;
  final FirebaseAuth _auth;
  final FirebaseMessaging _messaging;
  UserRemoteDataSource(
    this._auth,
    this._firestore,
    this._messaging,
    this._storage,
  );
  Future<void> updateProfile(UserModel user) async {
    if (user.name != null) {
      await _auth.currentUser?.updateDisplayName(user.name);
    }
    Map<String, dynamic> userJson = {};
    user.toJson().forEach((key, value) {
      if (value != null) {
        userJson[key] = value;
      }
    });
    await _firestore.collection('users').doc(user.uid).set(
          userJson,
          SetOptions(
            merge: true,
          ),
        );
    FirebaseAuth.instance.currentUser?.reload();
  }

  Future<String> updateUserAvatar(File image,
      {bool toggleFirestore = false}) async {
    final uploadService = UploadService(_storage.ref());

    final response = await uploadService.uploadFile(image,
        "images/users/${_auth.currentUser?.uid}/avatar${extension(image.path)}");
    await _auth.currentUser?.updatePhotoURL(response);
    if (toggleFirestore) {
      updateProfile(
        UserModel(
          uid: _auth.currentUser!.uid,
          avatar: response,
        ),
      );
    }
    return response;
  }

  Future<UserModel?> getUser(String uid) async {
    final response = await _firestore.collection('users').doc(uid).get();
    if (response.exists) {
      return UserModel.fromJson(response.data()!);
    }
    return null;
  }

  Future<void> addFriend(UserModel user) async {
    final currentUid = _auth.currentUser!.uid;
    final currentUser = await getUser(currentUid);
    await _firestore
        .collection("users")
        .doc(currentUid)
        .collection("friends")
        .doc(user.uid)
        .set(
          user.toJson(),
          SetOptions(
            merge: true,
          ),
        );
    await _firestore
        .collection("users")
        .doc(user.uid)
        .collection('friends')
        .doc(currentUid)
        .set(
          currentUser!.toJson(),
          SetOptions(
            merge: true,
          ),
        );
  }

  Future<List<UserModel>> getFriends() async {
    final uid = _auth.currentUser?.uid;
    final response = await _firestore
        .collection("users")
        .doc(uid)
        .collection('friends')
        .get();
    return response.docs.map((e) => UserModel.fromJson(e.data())).toList();
  }

  Future<String> getUserAvatar(String? uid) async {
    if (uid == null) {
      return "";
    }
    final uploadService = UploadService(_storage.ref());

    final response =
        await uploadService.getDownloadUrl("images/users/$uid/avatar.png");
    return response;
  }

  Future<void> updateFcmToken() async {
    final fcmToken = await _messaging.getToken();
    final uid = _auth.currentUser!.uid;
    await _firestore.collection('users').doc(uid).set(

      {
        'fcmToken': fcmToken,
      },
      SetOptions(merge: true),
    );
  }
}
