import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

@RoutePage()
class UserQRPage extends StatelessWidget {
  const UserQRPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My QR Code"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 48,
            ),
            Text(FirebaseAuth.instance.currentUser!.displayName ?? "Name"),
            SizedBox(
              height: 24,
            ),
            SizedBox(
              width: 250,
              child: PrettyQrView.data(
                  data: "chaticouid:${FirebaseAuth.instance.currentUser!.uid}"),
            ),
            SizedBox(
              height: 24,
            ),
            Text("UID: ${FirebaseAuth.instance.currentUser!.uid}"),
          ],
        ),
      ),
    );
  }
}
