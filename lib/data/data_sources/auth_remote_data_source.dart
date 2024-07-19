import 'package:firebase_auth/firebase_auth.dart';

class AuthRemoteDataSource {
  final FirebaseAuth _auth;
  AuthRemoteDataSource(this._auth);

  Future<ConfirmationResult> login(String phoneNumber) async {
    final response = await _auth.signInWithPhoneNumber(phoneNumber);
    return response;
  }
}
