import 'package:auto_route/auto_route.dart';
import 'package:chatico/common/utils/utils.dart';
import 'package:chatico/common/widgets/user_avatar.dart';
import 'package:chatico/data/data_sources/chat_remote_data_source.dart';
import 'package:chatico/data/models/chat_room.dart';
import 'package:chatico/presentation/pages/chat/widgets/chat_item.dart';
import 'package:chatico/presentation/pages/chat/widgets/message_box.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ChatPage extends StatelessWidget {
  final ChatRoom chatRoom;
  final messageController = TextEditingController();
  final scrollController = ScrollController();

  ChatPage({super.key, required this.chatRoom});

  @override
  Widget build(BuildContext context) {
    final intercolutor = Utils.getIntercolutor(chatRoom.users);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Hero(
              tag: "intercolutorAvatar",
              child: UserAvatar(intercolutor.uid),
            ),
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
                stream:
                    ChatRemoteDataSource().getMessages(chatRoom.roomId ?? ""),
                builder: (context, snapshot) {
                  if (snapshot.data?.isEmpty ?? true) {
                    return const Center(
                      child: Text("Send new message to stasrt conversation"),
                    );
                  }
                  ChatRemoteDataSource().resetUnreadedMessage(chatRoom);
                  return ListView.builder(
                    reverse: true,
                    controller: scrollController,
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      return ChatItem(
                        message: snapshot.data![index],
                        chatRoom: chatRoom,
                      );
                    },
                  );
                },
              ),
            ),
            MessageBox(
              messageController: messageController,
              chatRoom: chatRoom,
            )
          ],
        ),
      ),
    );
  }
}
