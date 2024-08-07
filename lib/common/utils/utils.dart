import 'dart:io';

import 'package:chatico/data/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_image_converter/flutter_image_converter.dart';
import 'package:path_provider/path_provider.dart';
import "package:path/path.dart";

class Utils {
  static String countryCodeToEmoji(String countryCode) {
    // 0x41 is Letter A
    // 0x1F1E6 is Regional Indicator Symbol Letter A
    // Example :
    // firstLetter U => 20 + 0x1F1E6
    // secondLetter S => 18 + 0x1F1E6
    // See: https://en.wikipedia.org/wiki/Regional_Indicator_Symbol
    final int firstLetter = countryCode.codeUnitAt(0) - 0x41 + 0x1F1E6;
    final int secondLetter = countryCode.codeUnitAt(1) - 0x41 + 0x1F1E6;
    return String.fromCharCode(firstLetter) + String.fromCharCode(secondLetter);
  }

  static Future<File> jpgToPng(File file) async {
    final bytes = file.pngUint8ListSync;
    final tempDir = await getTemporaryDirectory();
    File newFile =
        await File('${tempDir.path}/${basename(file.path).split(".")[0]}.png')
            .create();
    newFile.writeAsBytesSync(bytes);
    return newFile;
  }

  static String roomId(String to) {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    if (uid.hashCode < to.hashCode) {
      return "$uid&$to";
    }
    return "$to&$uid";
  }

  static UserModel getIntercolutor(List<UserModel> users) {
    if (users.length == 1) return users.first;
    final uid = FirebaseAuth.instance.currentUser!.uid;
    if (users.first.uid == uid) {
      return users[1];
    }
    return users[0];
  }
}
