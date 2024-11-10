import 'package:chat/constants/router.dart';
import 'package:chat/features/chat/chat_controller.dart';
import 'package:chat/models/chat_contact_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class ChatView extends ConsumerStatefulWidget {
  const ChatView({super.key});

  @override
  ConsumerState<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends ConsumerState<ChatView> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ChatContact>>(
      stream: ref.watch(chatControllerProvider).chatContacts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            var chatContactData = snapshot.data![index];

            return ListTile(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  conversationRoute,
                  arguments: {
                    'name': chatContactData.name,
                    'uid': chatContactData.contactId,
                    'profilePic': chatContactData.profilePic,
                    'isGroupChat': false,
                  },
                );
              },
              leading: CircleAvatar(
                radius: 24,
                backgroundImage: NetworkImage(chatContactData.profilePic),
              ),
              title: Text(
                chatContactData.name,
                style: const TextStyle(fontSize: 18),
              ),
              subtitle: Text(
                chatContactData.lastMessage,
                style: const TextStyle(fontSize: 14),
              ),
              trailing: Text(
                DateFormat.Hm().format(chatContactData.timeSent),
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
