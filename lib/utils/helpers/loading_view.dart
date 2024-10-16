import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {
  final String text;
  const LoadingView({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 20),
            Text(text),
          ],
        ),
      ),
    );
  }
}
