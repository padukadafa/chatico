import 'dart:io';

import 'package:chatico/common/utils/utils.dart';
import 'package:firebase_storage/firebase_storage.dart';
import "package:path/path.dart";

class UploadService {
  final Reference _storage;
  UploadService(this._storage);
  Future<String> uploadFile(File file, String path) async {
    if (extension(file.path) == ".jpeg" || extension(file.path) == ".jpg") {
      file = await Utils.jpgToPng(file);
      path = path.replaceAll(extension(path), ".png");
    }
    final ref = _storage.child(path);

    await ref.putFile(file);
    return await ref.getDownloadURL();
  }

  Future<String> getDownloadUrl(String path) async {
    final ref = _storage.child(path);
    return await ref.getDownloadURL();
  }
}
