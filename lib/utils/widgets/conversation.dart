import 'package:chat/utils/widgets/message_card.dart';
import 'package:flutter/material.dart';

class Conversation extends StatefulWidget {
  const Conversation({super.key});

  @override
  State<Conversation> createState() => _ConversationState();
}

class _ConversationState extends State<Conversation> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 12,
      itemBuilder: (context, index) {
        return const Column(
          children: [
            MessageCard(
              message: "Hey! How's it going?",
              time: '10:00 am',
              isSentByMe: true,
            ),
            MessageCard(
              message: "Sure, let's meet at 5PM tomorrow. Can't wait!",
              time: '10:00 am',
              isSentByMe: false,
            ),
          ],
        );
      },
    );
  }
}
