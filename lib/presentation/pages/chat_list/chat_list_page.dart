import 'package:auto_route/auto_route.dart';
import 'package:chatico/common/utils/utils.dart';
import 'package:chatico/common/widgets/user_avatar.dart';
import 'package:chatico/core/router/app_router.dart';
import 'package:chatico/data/data_sources/chat_remote_data_source.dart';
import 'package:chatico/data/models/chat_room.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

@RoutePage()
class ChatListPage extends StatelessWidget {
  const ChatListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chatico"),
        actions: [
          PopupMenuButton(
            iconSize: 28,
            padding: EdgeInsets.zero,
            offset: const Offset(0, 42),
            constraints: const BoxConstraints(minWidth: 200),
            color: colorScheme.surfaceBright,
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: const Text("Profile"),
                  onTap: () {},
                ),
                PopupMenuItem(
                  child: const Text("Settings"),
                  onTap: () {},
                ),
                PopupMenuItem(
                  child: const Text("Logout"),
                  onTap: () async {
                    FirebaseAuth.instance.signOut();
                    context.router.pushAndPopUntil(const LoginRoute(),
                        predicate: (r) => false);
                  },
                ),
              ];
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.router.push(const FriendsListRoute());
        },
        shape: const CircleBorder(),
        child: const FaIcon(FontAwesomeIcons.solidMessage),
      ),
      body: StreamBuilder<List<ChatRoom>>(
          stream: ChatRemoteDataSource().getChatRooms(),
          builder: (context, snapshot) {
            return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                if (!snapshot.hasData) {
                  return const SizedBox();
                }
                final intercolutor =
                    Utils.getIntercolutor(snapshot.data![index].users);
                final chatRoom = snapshot.data![index];
                return ListTile(
                  onTap: () {
                    context.router.push(ChatRoute(
                      chatRoom: snapshot.data?[index] ?? const ChatRoom(),
                    ));
                  },
                  leading: Hero(
                    tag: "intercolutorAvatar",
                    child: UserAvatar(intercolutor.uid),
                  ),
                  title: Text(intercolutor.name ?? ""),
                  subtitle: Text(chatRoom.lastMessage?.message ?? ""),
                  trailing: Visibility(
                    visible: chatRoom.unreadedMessage != 0 &&
                        chatRoom.lastMessage?.sender !=
                            FirebaseAuth.instance.currentUser?.uid,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: colorScheme.primary,
                      ),
                      child: Text(
                        chatRoom.unreadedMessage.toString(),
                        style: TextStyle(
                          color: colorScheme.onPrimary,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}
