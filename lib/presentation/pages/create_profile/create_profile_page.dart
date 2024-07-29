import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:chatico/core/router/app_router.dart';
import 'package:chatico/data/data_sources/user_remote_data_source.dart';
import 'package:chatico/data/models/user.dart';
import 'package:chatico/di.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

@RoutePage()
class CreateProfilePage extends StatefulWidget {
  const CreateProfilePage({super.key});

  @override
  State<CreateProfilePage> createState() => _CreateProfilePageState();
}

class _CreateProfilePageState extends State<CreateProfilePage> {
  final _nameController = TextEditingController();
  File? _avatarImage;
  final _userRemoteDataSource = getIt<UserRemoteDataSource>();
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_avatarImage == null) {
            return;
          }
          if (_nameController.text.isEmpty) {
            return;
          }
          setState(() {
            _loading = true;
          });
          final avatarResponse =
              await _userRemoteDataSource.updateUserAvatar(_avatarImage!);
          final user = UserModel(
            uid: FirebaseAuth.instance.currentUser!.uid,
            name: _nameController.text,
            phoneNumber: FirebaseAuth.instance.currentUser?.phoneNumber,
            avatar: avatarResponse,
          );
          await _userRemoteDataSource.updateProfile(user);
          await _userRemoteDataSource.updateFcmToken();

          setState(() {
            _loading = false;
          });
          context.router.pushAndPopUntil(
            const LoadingRoute(),
            predicate: (route) => false,
          );
        },
        child: _loading
            ? const CircularProgressIndicator()
            : const FaIcon(
                FontAwesomeIcons.arrowRight,
              ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Profile",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const Text("Complete your profile to continue"),
            const SizedBox(
              height: 24,
            ),
            GestureDetector(
              onTap: () async {
                final ImagePicker picker = ImagePicker();
                final XFile? image =
                    await picker.pickImage(source: ImageSource.gallery);
                if (image != null) {
                  setState(() {
                    _avatarImage = File(image.path);
                  });
                }
              },
              child: SizedBox(
                width: 140,
                height: 140,
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 70,
                      backgroundImage: _avatarImage != null
                          ? FileImage(_avatarImage!)
                          : null,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 4,
                            )
                          ],
                        ),
                        child: const FaIcon(
                          FontAwesomeIcons.camera,
                          size: 18,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 36),
              child: TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  label: Text("Name"),
                  hintText: "e.g John",
                ),
              ),
            ),
            const SizedBox(
              height: 82,
            ),
          ],
        ),
      ),
    );
  }
}
