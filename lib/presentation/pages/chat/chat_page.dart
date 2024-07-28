import 'package:auto_route/auto_route.dart';
import 'package:chatico/common/utils/utils.dart';
import 'package:chatico/common/widgets/user_avatar.dart';
import 'package:chatico/data/data_sources/chat_remote_data_source.dart';
import 'package:chatico/data/models/chat_room.dart';
import 'package:chatico/data/models/message.dart';
import 'package:chatico/presentation/pages/chat/widgets/chat_item.dart';
import 'package:chatico/presentation/pages/chat/widgets/message_box.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

@RoutePage()
class ChatPage extends StatefulWidget {
  final ChatRoom chatRoom;

  const ChatPage({super.key, required this.chatRoom});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final messageController = TextEditingController();

  final scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    ChatRemoteDataSource().updateFcmToken(widget.chatRoom);
  }

  @override
  Widget build(BuildContext context) {
    final intercolutor = Utils.getIntercolutor(widget.chatRoom.users);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            UserAvatar(url: intercolutor.avatar),
            SizedBox(
              width: 16,
            ),
            Text(intercolutor.name ?? ""),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/wallpapers/aesthetic_hearts.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: ChatRemoteDataSource()
                    .getMessages(widget.chatRoom.roomId ?? ""),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return ListView.builder(
                      controller: scrollController,
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return Skeletonizer(
                          containersColor: Colors.white,
                          enabled: true,
                          child: ChatItem(
                            message: Message(
                              message: BoneMock.paragraph,
                              createdAt: DateTime.now(),
                              sender: (index == 2)
                                  ? FirebaseAuth.instance.currentUser?.uid
                                  : "",
                            ),
                            chatRoom: ChatRoom(),
                          ),
                        );
                      },
                    );
                  }
                  if (snapshot.data?.isEmpty ?? true) {
                    return const Center(
                      child: Text("Send new message to start conversation"),
                    );
                  }
                  ChatRemoteDataSource().resetUnreadedMessage(widget.chatRoom);
                  return ListView.builder(
                    reverse: true,
                    controller: scrollController,
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      return ChatItem(
                        message: snapshot.data![index],
                        chatRoom: widget.chatRoom,
                      );
                    },
                  );
                },
              ),
            ),
            MessageBox(
              messageController: messageController,
              chatRoom: widget.chatRoom,
            )
          ],
        ),
      ),
    );
  }
}
