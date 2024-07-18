import 'package:auto_route/auto_route.dart';
import 'package:chatico/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

@RoutePage()
class ChatListPage extends StatelessWidget {
  const ChatListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chatico"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const FaIcon(
              FontAwesomeIcons.ellipsisVertical,
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: const CircleBorder(),
        child: const FaIcon(FontAwesomeIcons.solidMessage),
      ),
      body: ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              context.router.push(const ChatRoute());
            },
            leading: const CircleAvatar(),
            title: const Text("Danang"),
            subtitle: const Text("Hi Bruh"),
            trailing: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colorScheme.primary,
              ),
              child: Text(
                "3",
                style: TextStyle(
                  color: colorScheme.onPrimary,
                  fontSize: 12,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
