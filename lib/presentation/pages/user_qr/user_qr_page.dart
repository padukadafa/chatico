import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
            CachedNetworkImage(
              imageUrl: FirebaseAuth.instance.currentUser!.photoURL ?? "",
              imageBuilder: (context, imageProvider) {
                return CircleAvatar(
                  radius: 48,
                  backgroundImage: imageProvider,
                );
              },
              errorWidget: (context, url, error) {
                return CircleAvatar(
                  radius: 48,
                );
              },
              placeholder: (context, url) {
                return CircleAvatar(
                  radius: 48,
                );
              },
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              FirebaseAuth.instance.currentUser!.displayName ?? "Name",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 48,
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
