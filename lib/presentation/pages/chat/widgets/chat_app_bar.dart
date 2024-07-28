import 'package:chatico/common/widgets/user_avatar.dart';
import 'package:chatico/data/models/message.dart';
import 'package:chatico/data/models/user.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class ChatAppBar extends StatefulWidget implements PreferredSizeWidget {
  const ChatAppBar({
    super.key,
    required this.intercolutor,
    required this.scrollController,
    required this.messages,
  });

  final UserModel intercolutor;
  final AutoScrollController scrollController;
  final List<Message> messages;

  @override
  State<ChatAppBar> createState() => _ChatAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}

class _ChatAppBarState extends State<ChatAppBar> {
  List<Message> _searchResult = [];
  bool _showSearch = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: _showSearch ? Colors.white : Colors.amber,
      title: _showSearch
          ? TextField(
              autofocus: true,
              decoration: const InputDecoration(
                hintText: "Search...",
              ),
              onChanged: (value) {
                _searchResult = widget.messages
                    .where((m) => m.message!.toLowerCase().contains(value))
                    .toList();
                if (_searchResult.isNotEmpty) {
                  final index = widget.messages.indexOf(_searchResult[0]);
                  widget.scrollController.scrollToIndex(index);
                  widget.scrollController.highlight(index);
                }
              },
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                UserAvatar(url: widget.intercolutor.avatar),
                const SizedBox(
                  width: 16,
                ),
                Text(widget.intercolutor.name ?? ""),
              ],
            ),
      actions: [
        _showSearch
            ? IconButton(
                onPressed: () {
                  widget.scrollController.cancelAllHighlights();

                  setState(() {
                    _showSearch = false;
                  });
                },
                icon: const Icon(
                  Icons.close,
                  size: 21,
                ),
              )
            : IconButton(
                onPressed: () {
                  setState(() {
                    _showSearch = true;
                  });
                },
                icon: const FaIcon(
                  FontAwesomeIcons.magnifyingGlass,
                  size: 21,
                ),
              ),
      ],
    );
  }
}
