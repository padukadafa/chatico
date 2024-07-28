import 'package:auto_route/auto_route.dart';
import 'package:chatico/common/utils/utils.dart';
import 'package:chatico/common/widgets/user_avatar.dart';
import 'package:chatico/core/extension/date_time.dart';
import 'package:chatico/data/data_sources/chat_remote_data_source.dart';
import 'package:chatico/data/models/chat_room.dart';
import 'package:chatico/data/models/message.dart';
import 'package:chatico/presentation/pages/chat/widgets/chat_item.dart';
import 'package:chatico/presentation/pages/chat/widgets/message_box.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grouped_list/grouped_list.dart';
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
        backgroundColor: Colors.amber,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            UserAvatar(url: intercolutor.avatar),
            const SizedBox(
              width: 16,
            ),
            Text(intercolutor.name ?? ""),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const FaIcon(
              FontAwesomeIcons.magnifyingGlass,
              size: 21,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      "assets/images/wallpapers/aesthetic_hearts.jpeg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Column(
            children: [
              StreamBuilder(
                stream: ChatRemoteDataSource()
                    .getMessages(widget.chatRoom.roomId ?? ""),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Expanded(
                      child: ListView.builder(
                        controller: scrollController,
                        itemCount: 8,
                        itemBuilder: (context, index) {
                          return Skeletonizer(
                            containersColor: Colors.white,
                            enabled: true,
                            child: ChatItem(
                              message: Message(
                                message: BoneMock.fullName,
                                createdAt: DateTime.now(),
                                sender: (index % 3 == 0)
                                    ? FirebaseAuth.instance.currentUser?.uid
                                    : "",
                              ),
                              chatRoom: const ChatRoom(),
                            ),
                          );
                        },
                      ),
                    );
                  }
                  if (snapshot.data?.isEmpty ?? true) {
                    return const Center(
                      child: Text("Send new message to start conversation"),
                    );
                  }
                  ChatRemoteDataSource().resetUnreadedMessage(widget.chatRoom);
                  return Expanded(
                    child: GroupedListView(
                      controller: scrollController,
                      elements: snapshot.data!,
                      reverse: true,
                      stickyHeaderBackgroundColor: Colors.transparent,
                      useStickyGroupSeparators: true,
                      groupBy: (e) => e.createdAt!.groupedDifferentFromNow(),
                      indexedItemBuilder: (context, element, index) {
                        return ChatItem(
                          message: snapshot.data![index],
                          chatRoom: widget.chatRoom,
                        );
                      },
                      groupStickyHeaderBuilder: (element) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 8),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      blurRadius: 6,
                                    ),
                                  ]),
                              child: Text(
                                  element.createdAt!.groupedDifferentFromNow()),
                            ),
                          ],
                        );
                      },
                      groupSeparatorBuilder: (element) {
                        return const SizedBox.shrink();
                      },
                    ),
                  );
                },
              ),
              MessageBox(
                messageController: messageController,
                chatRoom: widget.chatRoom,
              )
            ],
          ),
        ],
      ),
    );
  }
}
