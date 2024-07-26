import 'package:chatico/data/models/message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:super_context_menu/super_context_menu.dart';

class ChatItem extends StatelessWidget {
  final Message message;
  const ChatItem({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final isSender = message.from == FirebaseAuth.instance.currentUser?.uid;
    return ContextMenuWidget(
      menuProvider: (MenuRequest request) {
        return Menu(
          children: [
            MenuAction(
              callback: () {},
              title: "Delete",
              image: MenuImage.icon(
                FontAwesomeIcons.trash,
              ),
              attributes: const MenuActionAttributes(
                destructive: true,
              ),
            ),
            MenuAction(
              callback: () {},
              title: "Copy",
              image: MenuImage.icon(
                FontAwesomeIcons.copy,
              ),
            ),
          ],
        );
      },
      child: Container(
        alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin: isSender
              ? const EdgeInsets.only(
                  top: 16,
                  left: 86,
                  right: 16,
                )
              : const EdgeInsets.only(
                  top: 16,
                  left: 16,
                  right: 86,
                ),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isSender ? Colors.amber[100] : colorScheme.surfaceBright,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                message.message ?? "",
              ),
              const SizedBox(
                height: 6,
              ),
              Text(DateFormat("hh:mm").format(message.createdAt!))
            ],
          ),
        ),
      ),
    );
  }
}
