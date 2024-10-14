import 'package:chat/constants/routes.dart';
import 'package:chat/theme/palette.dart';
import 'package:flutter/material.dart';

class UpdateView extends StatefulWidget {
  const UpdateView({super.key});

  @override
  State<UpdateView> createState() => _UpdateViewState();
}

class _UpdateViewState extends State<UpdateView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 5,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            Navigator.of(context).pushNamed(updateRoute);
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
            '11:00 am',
            style: TextStyle(fontSize: 14),
          ),
        );
      },
    );
  }
}
