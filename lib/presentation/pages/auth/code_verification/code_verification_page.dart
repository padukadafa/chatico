import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:chatico/core/router/app_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

@RoutePage()
class CodeVerificationPage extends StatefulWidget {
  final String phoneNumber;
  const CodeVerificationPage({
    super.key,
    required this.phoneNumber,
  });

  @override
  State<CodeVerificationPage> createState() => _CodeVerificationPageState();
}

class _CodeVerificationPageState extends State<CodeVerificationPage> {
  final _auth = FirebaseAuth.instance;
  String? _error;
  bool _loading = false;
  String? _verificationId;
  int? _resendToken;
  late Timer _timer;
  int _start = 60;
  @override
  void initState() {
    super.initState();
    startTimer();
    _auth.verifyPhoneNumber(
      phoneNumber: widget.phoneNumber,
      verificationCompleted: (phoneAuthCredential) {},
      verificationFailed: (error) {},
      codeSent: (verificationId, forceResendingToken) {
        _verificationId = verificationId;
        _resendToken = forceResendingToken;
      },
      codeAutoRetrievalTimeout: (verificationId) {},
    );
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Verification",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Text(
              "Enter code sent to number",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              widget.phoneNumber,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 48,
            ),
            Pinput(
              length: 6,
              forceErrorState: _error != null,
              onCompleted: (val) async {
                setState(() {
                  _error = null;
                  _loading = true;
                });
                try {
                  print(_verificationId);
                  if (_verificationId != null) {
                    PhoneAuthCredential credential =
                        PhoneAuthProvider.credential(
                            verificationId: _verificationId!, smsCode: val);
                    await _auth.signInWithCredential(credential);
                    context.router.pushAndPopUntil(
                      ChatListRoute(),
                      predicate: (route) => false,
                    );
                  }
                  setState(() {
                    _error = null;
                    _loading = false;
                  });
                } on FirebaseAuthException catch (e) {
                  if (e.code == "invalid-verification-code") {
                    setState(() {
                      _error = "Invalid Code";
                      _loading = false;
                    });
                  }
                }
              },
            ),
            SizedBox(
              height: 24,
            ),
            Visibility(
              child: CircularProgressIndicator(),
              visible: _loading,
            ),
            Visibility(
              visible: _error != null,
              child: Text(
                _error ?? "",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
            SizedBox(
              height: 48,
            ),
            Text("Didn't receive code?"),
            TextButton.icon(
              onPressed: () async {
                if (_start != 0) {
                  return;
                }
                setState(() {
                  _loading = true;
                });
                try {
                  await _auth.verifyPhoneNumber(
                    phoneNumber: widget.phoneNumber,
                    verificationCompleted: (phoneAuthCredential) {},
                    verificationFailed: (error) {
                      setState(() {
                        _loading = false;
                        _error = error.message;
                      });
                    },
                    codeSent: (verificationId, forceResendingToken) {
                      _verificationId = verificationId;
                      _resendToken = forceResendingToken;
                      _start = 60;
                      startTimer();
                    },
                    codeAutoRetrievalTimeout: (verificationId) {},
                    forceResendingToken: _resendToken,
                  );
                  setState(() {
                    _loading = false;
                    _error = null;
                  });
                } catch (e) {
                  setState(() {
                    _loading = false;
                  });
                }
              },
              label: Text("Resend"),
              icon: Text(_start == 0 ? "" : _start.toString()),
            ),
          ],
        ),
      ),
    );
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }
}
