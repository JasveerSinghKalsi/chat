import 'package:chat/features/select_contact/select_contact_controller.dart';
import 'package:chat/theme/palette.dart';
import 'package:chat/utils/helpers/error_view.dart';
import 'package:chat/utils/helpers/loading_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectContactsView extends ConsumerWidget {
  const SelectContactsView({super.key});

  void selectContact(
      BuildContext context, WidgetRef ref, Contact selectedContact) {
    ref
        .read(selectContactControllerProvider)
        .selectContact(context, selectedContact);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Contact'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: ref.watch(getContactsProvider).when(
            data: (contactList) => ListView.builder(
              itemCount: contactList.length,
              itemBuilder: (context, index) {
                final contact = contactList[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    onTap: () => selectContact(context, ref, contact),
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundColor: Palette.tabColor,
                      foregroundImage: contact.photo == null
                          ? null
                          : MemoryImage(contact.photo!),
                    ),
                    title: Text(contact.displayName),
                    subtitle: Text(contact.phones.first.number),
                  ),
                );
              },
            ),
            error: (err, trace) => ErrorView(error: err.toString()),
            loading: () => const LoadingView(),
          ),
    );
  }
}
