import 'package:chat/constants/router.dart';
import 'package:chat/models/user_model.dart';
import 'package:chat/utils/helpers/show_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectContactRepositoryProvider = Provider(
    (ref) => SelectContactRepository(firestore: FirebaseFirestore.instance));

class SelectContactRepository {
  final FirebaseFirestore firestore;

  SelectContactRepository({
    required this.firestore,
  });

  Future<List<Contact>> getContacts() async {
    List<Contact> contacts = [];
    try {
      if (await FlutterContacts.requestPermission()) {
        contacts = await FlutterContacts.getContacts(withProperties: true);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return contacts;
  }

  void selectContact(BuildContext context, Contact selectedContact) async {
    try {
      var userCollection = await firestore.collection('users').get();
      bool isFound = false;

      for (var document in userCollection.docs) {
        var userData = UserModel.fromMap(document.data());
        String selectedPhoneNumber =
            selectedContact.phones.first.number.replaceAll(' ', '');
        if (context.mounted) {
          if (selectedPhoneNumber == userData.phoneNumber) {
            isFound = true;
            Navigator.of(context).pushReplacementNamed(
              conversationRoute,
              arguments: {
                'name': userData.name,
                'uid': userData.uid,
                'profilePic': userData.profilePic,
                'isGroupChat': false
              },
            );
          }

          if (!isFound) {
            showSnackBar(
                context: context, content: 'This number doesnot exists');
          }
        }
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context: context, content: e.toString());
      }
    }
  }
}
