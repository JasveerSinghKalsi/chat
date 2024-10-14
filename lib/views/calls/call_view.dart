import 'package:chat/constants/routes.dart';
import 'package:chat/theme/palette.dart';
import 'package:flutter/material.dart';

class CallView extends StatefulWidget {
  const CallView({super.key});

  @override
  State<CallView> createState() => _CallViewState();
}

class _CallViewState extends State<CallView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 12,
      itemBuilder: (context, index) {
        return ListTile(
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
              '11:00 am',
              style: TextStyle(fontSize: 14),
            ),
            trailing: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(callRoute);
                },
                icon: const Icon(Icons.call)));
      },
    );
  }
}
