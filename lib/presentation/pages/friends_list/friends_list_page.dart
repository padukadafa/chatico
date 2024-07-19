import 'package:auto_route/auto_route.dart';
import 'package:chatico/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

@RoutePage()
class FriendsListPage extends StatelessWidget {
  const FriendsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Start new chat"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              onTap: () {
                context.router.push(QrScannerRoute());
              },
              title: Text("Add new friend"),
              leading: FaIcon(
                FontAwesomeIcons.userPlus,
                size: 21,
              ),
            ),
            ListTile(
              onTap: () {
                context.router.push(const UserQRRoute());
              },
              title: Text("Show my QR"),
              leading: FaIcon(
                FontAwesomeIcons.qrcode,
                size: 21,
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: 16,
                top: 12,
                bottom: 12,
              ),
              child: Text(
                "Your friends",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            Column(
              children: List.generate(
                4,
                (index) {
                  return ListTile(
                    onTap: () {},
                    leading: const CircleAvatar(),
                    title: const Text("Danang"),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
