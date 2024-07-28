import 'package:chatico/data/data_sources/chat_remote_data_source.dart';
import 'package:chatico/data/models/chat_room.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

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
        horizontal: 12,
        vertical: 4,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(26),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Row(
                children: [
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      decoration: const InputDecoration(
                        hintText: "Message",
                        border: InputBorder.none,
                      ),
                      maxLines: 4,
                      minLines: 1,
                      onSubmitted: (val) {
                        _sendMessage(val);
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      final List<AssetEntity>? result =
                          await AssetPicker.pickAssets(context);
                    },
                    icon: const FaIcon(
                      FontAwesomeIcons.images,
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          IconButton.filled(
            onPressed: () {
              _sendMessage(messageController.text);
            },
            icon: const FaIcon(
              FontAwesomeIcons.solidPaperPlane,
              color: Colors.white,
            ),
            style: IconButton.styleFrom(
              backgroundColor: Colors.amber,
            ),
          ),
        ],
      ),
    );
  }

  _sendMessage(String message) async {
    ChatRemoteDataSource().sendMessage(chatRoom, message: message);
    messageController.clear();
  }
}
