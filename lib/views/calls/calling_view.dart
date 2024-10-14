import 'package:chat/theme/palette.dart';
import 'package:flutter/material.dart';

class CallingView extends StatelessWidget {
  const CallingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.appBarColor,
        title: const Text('Calling'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: const Center(
        child: Column(
          children: [
            SizedBox(height: 20),
            Text(
              'Person',
              style: TextStyle(fontSize: 50),
            ),
            SizedBox(height: 20),
            CircleAvatar(
              radius: 100,
              backgroundColor: Palette.profileColor,
            ),
            SizedBox(height: 250),
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.red,
              child: Icon(Icons.call_end),
            ),
          ],
        ),
      ),
    );
  }
}
