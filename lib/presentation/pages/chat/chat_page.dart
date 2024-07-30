import 'package:auto_route/auto_route.dart';
import 'package:chatico/common/utils/utils.dart';
import 'package:chatico/common/widgets/user_avatar.dart';
import 'package:chatico/data/data_sources/chat_remote_data_source.dart';
import 'package:chatico/data/models/chat_room.dart';
import 'package:chatico/data/models/message.dart';
import 'package:chatico/data/models/user.dart';
import 'package:chatico/presentation/pages/chat/widgets/chat_app_bar.dart';
import 'package:chatico/presentation/pages/chat/widgets/message_box.dart';
import 'package:chatico/presentation/pages/chat/widgets/message_list.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

@RoutePage()
class ChatPage extends StatefulWidget {
  final ChatRoom chatRoom;

  const ChatPage({super.key, required this.chatRoom});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final messageController = TextEditingController();

  late AutoScrollController scrollController;

  bool _showSearch = true;
  @override
  void initState() {
    super.initState();
    ChatRemoteDataSource().updateFcmToken(widget.chatRoom);
    scrollController = AutoScrollController(
        viewportBoundaryGetter: () =>
            Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
        axis: Axis.vertical);
  }

  List<Message> _messages = [];
  @override
  Widget build(BuildContext context) {
    final intercolutor = Utils.getIntercolutor(widget.chatRoom.users);

    return Scaffold(
      appBar: ChatAppBar(
        intercolutor: intercolutor,
        scrollController: scrollController,
        messages: _messages,
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
              MessageList(
                chatRoom: widget.chatRoom,
                scrollController: scrollController,
                onMessageUpdate: (val) {
                  _messages = val;
                },
              ),
              MessageBox(
                messageController: messageController,
                chatRoom: widget.chatRoom,
                scrollController: scrollController,

              )
            ],
          ),
        ],
      ),
    );
  }
}
