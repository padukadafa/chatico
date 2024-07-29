import 'package:auto_route/auto_route.dart';
import 'package:chatico/common/values/app_constants.dart';
import 'package:chatico/common/widgets/user_avatar.dart';
import 'package:chatico/core/router/app_router.dart';
import 'package:chatico/di.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

@RoutePage()
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 36),
              width: double.maxFinite,
              height: 100,
              color: Colors.white,
              child: Row(
                children: [
                  UserAvatar(
                    url: FirebaseAuth.instance.currentUser?.photoURL,
                    radius: 32,
                  ),
                  SizedBox(
                    width: 21,
                  ),
                  Text(
                    FirebaseAuth.instance.currentUser?.displayName ?? "",
                    style: TextStyle(
                      fontSize: 21,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Info"),
                  ListTile(
                    title: Text(
                        FirebaseAuth.instance.currentUser?.phoneNumber ?? ""),
                    subtitle: Text("Phone number"),
                  ),
                  ListTile(
                    title: Text(FirebaseAuth.instance.currentUser?.uid ?? ""),
                    subtitle: Text("Uid"),
                    trailing: IconButton(
                      onPressed: () {
                        context.router.push(
                          UserQRRoute(),
                        );
                      },
                      icon: FaIcon(Icons.qr_code),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Settings"),
                  SettingsShowNotification(),
                  // ListTile(
                  //   title: Text("Chat Background"),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsShowNotification extends StatefulWidget {
  const SettingsShowNotification({
    super.key,
  });

  @override
  State<SettingsShowNotification> createState() =>
      _SettingsShowNotificationState();
}

class _SettingsShowNotificationState extends State<SettingsShowNotification> {
  late bool _showNotification;
  @override
  void initState() {
    _showNotification =
        getIt<SharedPreferences>().getBool(AppConstants.SHOW_NOTIFICATION) ??
            false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("Show Notification"),
      trailing: Switch(
        value: _showNotification,
        onChanged: (val) async {
          setState(() {
            _showNotification = val;
          });
          getIt<SharedPreferences>()
              .setBool(AppConstants.SHOW_NOTIFICATION, val);
        },
      ),
    );
  }
}
