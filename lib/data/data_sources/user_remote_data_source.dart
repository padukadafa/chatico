import 'dart:io';

import 'package:chatico/common/services/upload_service.dart';
import 'package:chatico/data/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class UserRemoteDataSource {
  final _firestore = FirebaseFirestore.instance.collection("users");
  final _storage = FirebaseStorage.instance.ref();
  final _auth = FirebaseAuth.instance;
  Future<void> updateProfile(UserModel user) async {
    if (user.name != null) {
      await _auth.currentUser?.updateDisplayName(user.name);
    }
    _firestore.doc(user.uid).set(
          user.toJson(),
          SetOptions(
            merge: true,
          ),
        );
  }

  Future<String> updateUserAvatar(File image) async {
    final uploadService = UploadService(_storage);

    final response = await uploadService.uploadFile(image,
        "images/users/${_auth.currentUser?.uid}/avatar${extension(image.path)}");
    await _auth.currentUser?.updatePhotoURL(response);
    return response;
  }

  Future<UserModel?> getUser(String uid) async {
    final response = await _firestore.doc(uid).get();
    if (response.exists) {
      return UserModel.fromJson(response.data()!);
    }
    return null;
  }

  Future<void> addFriend(String uid) async {
    final user = await getUser(uid);
    if (user == null) {
      throw Exception("User not Found");
    }
    final currentUid = _auth.currentUser!.uid;
    final currentUser = await getUser(currentUid);
    await _firestore.doc(currentUid).collection("friends").doc(user.uid).set(
          user.toJson(),
          SetOptions(
            merge: true,
          ),
        );
    await _firestore.doc(user.uid).collection('friends').doc(currentUid).set(
          currentUser!.toJson(),
          SetOptions(
            merge: true,
          ),
        );
  }

  Future<List<UserModel>> getFriends() async {
    final uid = _auth.currentUser?.uid;
    final response = await _firestore.doc(uid).collection('friends').get();
    return response.docs.map((e) => UserModel.fromJson(e.data())).toList();
  }

  Future<String> getUserAvatar(String uid) async {
    final uploadService = UploadService(_storage);
    final response =
        await uploadService.getDownloadUrl("images/users/$uid/avatar.png");
    return response;
  }
}
