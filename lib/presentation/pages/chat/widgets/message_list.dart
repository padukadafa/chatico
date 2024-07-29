import 'package:chatico/core/extension/date_time.dart';
import 'package:chatico/data/data_sources/chat_remote_data_source.dart';
import 'package:chatico/data/models/chat_room.dart';
import 'package:chatico/data/models/message.dart';
import 'package:chatico/presentation/pages/chat/widgets/chat_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MessageList extends StatelessWidget {
  const MessageList({
    super.key,
    required this.chatRoom,
    required this.scrollController,
    required this.onMessageUpdate,
  });

  final ChatRoom chatRoom;
  final AutoScrollController scrollController;
  final void Function(List<Message>) onMessageUpdate;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: ChatRemoteDataSource().getMessages(chatRoom.roomId ?? ""),
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
        onMessageUpdate(snapshot.data!);
        if (snapshot.data?.isEmpty ?? true) {
          return const Expanded(
            child: Center(
              child: Text("Send new message to start conversation"),
            ),
          );
        }

        ChatRemoteDataSource().resetUnreadedMessage(chatRoom);
        return Expanded(
          child: GroupedListView(
            controller: scrollController,
            elements: snapshot.data!,
            stickyHeaderBackgroundColor: Colors.transparent,
            useStickyGroupSeparators: true,
            reverse: true,
            dragStartBehavior: DragStartBehavior.down,
            groupBy: (e) => e.createdAt!.groupedDifferentFromNow(),
            groupComparator: (value1, value2) => value2.compareTo(value1),
            indexedItemBuilder: (context, element, index) {
              return AutoScrollTag(
                index: index,
                key: ValueKey(index),
                controller: scrollController,
                highlightColor: Colors.yellow.withOpacity(0.2),
                child: ChatItem(
                  message: snapshot.data![index],
                  chatRoom: chatRoom,
                ),
              );
            },
            groupStickyHeaderBuilder: (element) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 6,
                          ),
                        ]),
                    child: Text(element.createdAt!.groupedDifferentFromNow()),
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
    );
  }
}
