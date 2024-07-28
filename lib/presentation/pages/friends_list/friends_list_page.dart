import 'package:auto_route/auto_route.dart';
import 'package:chatico/common/utils/utils.dart';
import 'package:chatico/common/widgets/user_avatar.dart';
import 'package:chatico/core/router/app_router.dart';
import 'package:chatico/data/data_sources/user_remote_data_source.dart';
import 'package:chatico/data/models/chat_room.dart';
import 'package:chatico/data/models/user.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skeletonizer/skeletonizer.dart';

@RoutePage()
class FriendsListPage extends StatelessWidget {
  const FriendsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final UserRemoteDataSource _dataSource = UserRemoteDataSource();

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
            FutureBuilder<List<UserModel>>(
                future: _dataSource.getFriends(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Skeletonizer(
                      enabled: true,
                      child: Column(
                        children: List.generate(
                          4,
                          (index) {
                            return ListTile(
                              leading: const CircleAvatar(),
                              title: Text(BoneMock.fullName),
                            );
                          },
                        ),
                      ),
                    );
                  }
                  if (snapshot.data?.isEmpty ?? true) {
                    return const Center(
                      child: Text("Invite your friend to start conversation"),
                    );
                  }
                  return Column(
                    children: List.generate(
                      snapshot.data?.length ?? 0,
                      (index) {
                        return ListTile(
                          onTap: () {
                            context.router.push(
                              ChatRoute(
                                chatRoom: ChatRoom(
                                  roomId:
                                      Utils.roomId(snapshot.data![index].uid),
                                  users: [
                                    snapshot.data![index],
                                  ],
                                ),
                              ),
                            );
                          },
                          leading:
                              UserAvatar(url: snapshot.data![index].avatar),
                          title: Text(snapshot.data![index].name ?? ""),
                        );
                      },
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
