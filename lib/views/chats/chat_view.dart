import 'package:chat/constants/routes.dart';
import 'package:chat/theme/palette.dart';
import 'package:flutter/material.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 12,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            Navigator.of(context).pushNamed(conversationRoute);
          },
          leading: const CircleAvatar(
            radius: 24,
            backgroundColor: Palette.profileColor,
            child: Icon(Icons.person),
          ),
          title: const Text(
            'Person',
            style: TextStyle(fontSize: 18),
          ),
          subtitle: const Text(
            'Hello',
            style: TextStyle(fontSize: 14),
          ),
          trailing: const Text(
            '11:00 am',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        );
      },
    );
  }
}
