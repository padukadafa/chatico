import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:super_context_menu/super_context_menu.dart';

@RoutePage()
class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(),
            SizedBox(
              width: 16,
            ),
            Text("Danang"),
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
              child: ListView.builder(
                itemCount: 12,
                itemBuilder: (context, index) {
                  if (index % 3 == 0) {
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
                        alignment: Alignment.centerRight,
                        child: Container(
                          margin: const EdgeInsets.only(
                            top: 16,
                            left: 86,
                            right: 16,
                          ),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.amber[100],
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                lorem(paragraphs: 1),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Text(DateFormat("hh:mm").format(DateTime.now()))
                            ],
                          ),
                        ),
                      ),
                    );
                  }
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
                            attributes: MenuActionAttributes(
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
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.only(
                          top: 16,
                          left: 16,
                          right: 86,
                        ),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceBright,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              lorem(paragraphs: 1),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(DateFormat("hh:mm").format(DateTime.now()))
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
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
              child: const Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Message",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  FaIcon(
                    FontAwesomeIcons.solidPaperPlane,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
