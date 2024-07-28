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
  int _currentIndex = 0;
  @override
  void dispose() {
    super.dispose();
    _searchResult = [];
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
                setState(() {
                  _currentIndex = 0;

                  _searchResult = widget.messages
                      .where((m) => m.message!.toLowerCase().contains(value))
                      .toList();
                });

                if (_searchResult.isNotEmpty) {
                  final index =
                      widget.messages.indexOf(_searchResult[_currentIndex]);

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
      leading: _showSearch
          ? IconButton(
              onPressed: () {
                widget.scrollController.cancelAllHighlights();

                setState(() {
                  _showSearch = false;
                  _searchResult = [];
                });
              },
              icon: const Icon(
                Icons.close,
                size: 21,
              ),
            )
          : null,
      actions: [
        if (_searchResult.isNotEmpty && _showSearch)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  if (_currentIndex > _searchResult.length - 2) {
                    return;
                  }
                  setState(() {
                    _currentIndex++;
                  });
                  final index =
                      widget.messages.indexOf(_searchResult[_currentIndex]);
                  widget.scrollController.scrollToIndex(index);
                  widget.scrollController.highlight(index);
                },
                icon: const Icon(
                  Icons.arrow_upward,
                  size: 18,
                ),
              ),
              Text("${_currentIndex + 1}/${_searchResult.length}"),
              IconButton(
                onPressed: () {
                  if (_currentIndex == 0) {
                    return;
                  }
                  setState(() {
                    _currentIndex--;
                  });
                  final index =
                      widget.messages.indexOf(_searchResult[_currentIndex]);
                  widget.scrollController.scrollToIndex(index);
                  widget.scrollController.highlight(index);
                },
                icon: const Icon(
                  Icons.arrow_downward,
                  size: 18,
                ),
              ),
            ],
          ),
        if (!_showSearch)
          IconButton(
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
