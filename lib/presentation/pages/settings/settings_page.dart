import 'package:auto_route/auto_route.dart';
import 'package:chatico/common/values/app_constants.dart';
import 'package:chatico/common/widgets/user_avatar.dart';
import 'package:chatico/core/router/app_router.dart';
import 'package:chatico/data/data_sources/user_remote_data_source.dart';
import 'package:chatico/data/models/user.dart';
import 'package:chatico/di.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

@RoutePage()
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late TextEditingController _nameController;
  bool _showTextField = false;
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
        text: FirebaseAuth.instance.currentUser?.displayName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
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
                      Container(
                        width: 72,
                        height: 72,
                        child: Stack(
                          children: [
                            UserAvatar(
                              url: FirebaseAuth.instance.currentUser?.photoURL,
                              radius: 32,
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: IconButton.filled(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.edit,
                                ),
                                iconSize: 14,
                                constraints: BoxConstraints(),
                                style: IconButton.styleFrom(
                                  padding: EdgeInsets.all(8),
                                  elevation: 0,
                                ),
                              ),
                            )
                          ],
                        ),
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
                      Expanded(child: SizedBox()),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _showTextField = true;
                          });
                        },
                        icon: Icon(Icons.edit),
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
                            FirebaseAuth.instance.currentUser?.phoneNumber ??
                                ""),
                        subtitle: Text("Phone number"),
                      ),
                      ListTile(
                        title:
                            Text(FirebaseAuth.instance.currentUser?.uid ?? ""),
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
          Align(
            alignment: Alignment.bottomCenter,
            child: Visibility(
              visible: _showTextField,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
                child: TextField(
                  controller: _nameController,
                  onTapOutside: (e) async {
                    _onUpdateName();
                  },
                  onSubmitted: (val) async {
                    await _onUpdateName();
                  },
                  decoration: InputDecoration(
                    hintText: "e.g John",
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _onUpdateName() async {
    setState(() {
      _showTextField = false;
    });
    if (_nameController.text.isNotEmpty) {
      await getIt<UserRemoteDataSource>().updateProfile(
        UserModel(
          uid: FirebaseAuth.instance.currentUser!.uid,
          name: _nameController.text,
        ),
      );

      setState(() {});
    }
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
      title: const Text("Show Notification"),
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
