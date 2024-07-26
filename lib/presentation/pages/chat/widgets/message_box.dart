import 'package:chatico/data/data_sources/chat_remote_data_source.dart';
import 'package:chatico/data/models/chat_room.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MessageBox extends StatelessWidget {
  const MessageBox({
    super.key,
    required this.messageController,
    required this.chatRoom,
  });

  final TextEditingController messageController;
  final ChatRoom chatRoom;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 10,
          )
        ],
        color: colorScheme.surfaceBright,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: messageController,
              decoration: const InputDecoration(
                hintText: "Message",
                border: InputBorder.none,
              ),
              onSubmitted: (val) {
                _sendMessage(val);
              },
            ),
          ),
          GestureDetector(
            onTap: () {
              _sendMessage(messageController.text);
            },
            child: const FaIcon(
              FontAwesomeIcons.solidPaperPlane,
            ),
          )
        ],
      ),
    );
  }

  _sendMessage(String message) async {
    ChatRemoteDataSource().sendMessage(chatRoom.roomId ?? "", message: message);
    messageController.clear();
  }
}
