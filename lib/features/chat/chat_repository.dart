import 'package:chat/models/chat_contact_model.dart';
import 'package:chat/models/message_model.dart';
import 'package:chat/models/user_model.dart';
import 'package:chat/utils/enums/message_enum.dart';
import 'package:chat/utils/helpers/show_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';

final chatRepositoryProvider = Provider(
  (ref) => ChatRepository(
    firestore: FirebaseFirestore.instance,
    auth: FirebaseAuth.instance,
  ),
);

class ChatRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  ChatRepository({
    required this.firestore,
    required this.auth,
  });

  Stream<List<ChatContact>> getChatContacts() {
    return firestore
        .collection('users')
        .doc(auth.currentUser?.uid) // Add null check for auth.currentUser
        .collection('chats')
        .snapshots()
        .asyncMap(
      (event) async {
        List<ChatContact> contacts = [];
        List<String> contactIds = event.docs.map((doc) => doc.id).toList();

        if (contactIds.isNotEmpty) {
          var userSnapshot = await firestore
              .collection('users')
              .where(FieldPath.documentId, whereIn: contactIds)
              .get();

          for (var document in event.docs) {
            var chatContact = ChatContact.fromMap(document.data());
            var userData = userSnapshot.docs
                .firstWhere((userDoc) => userDoc.id == chatContact.contactId);
            var user = UserModel.fromMap(userData.data());

            contacts.add(ChatContact(
              name: user.name,
              profilePic: user.profilePic,
              contactId: chatContact.contactId,
              lastMessage: chatContact.lastMessage,
              timeSent: chatContact.timeSent,
            ));
          }
        }
        return contacts;
      },
    );
  }

  void _saveMessageToMessageSubCollection(
      {required String recieverUserId,
      required String text,
      required DateTime timeSent,
      required String messageId,
      required MessageEnum messageType,
      required String senderUsername,
      required String? receiverUsername,
      required bool isGroupChat}) async {
    final message = MessageModel(
      senderUserId: auth.currentUser!.uid,
      receiverUserId: recieverUserId,
      text: text,
      type: messageType,
      timeSent: timeSent,
      messageId: messageId,
      isSeen: false,
    );

    // users -> senderUserId -> receiverUserId -> messages -> messageId -> store message
    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(recieverUserId)
        .collection('messages')
        .doc(messageId)
        .set(message.toMap());
    // users -> receiverUserId  -> senderUserId -> messages -> messageId -> store message
    await firestore
        .collection('users')
        .doc(recieverUserId)
        .collection('chats')
        .doc(auth.currentUser!.uid)
        .collection('messages')
        .doc(messageId)
        .set(message.toMap());
  }

  void sendTextMessage({
    required BuildContext context,
    required String text,
    required String recieverUserId,
    required UserModel senderUserData,
    required bool isGroupChat,
  }) async {
    try {
      var timeSent = DateTime.now();

      UserModel? recieverUserData;

      if (!isGroupChat) {
        var userDataMap =
            await firestore.collection('users').doc(recieverUserId).get();
        recieverUserData = UserModel.fromMap(userDataMap.data()!);
      }

      var messageId = const Uuid().v1();

      _saveMessageToMessageSubCollection(
        recieverUserId: recieverUserId,
        text: text,
        timeSent: timeSent,
        messageType: MessageEnum.text,
        messageId: messageId,
        senderUsername: senderUserData.name,
        receiverUsername: recieverUserData?.name,
        isGroupChat: isGroupChat,
      );
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context: context, content: e.toString());
      }
    }
  }
}
