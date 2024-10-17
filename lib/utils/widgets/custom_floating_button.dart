import 'package:chat/theme/palette.dart';
import 'package:flutter/material.dart';

class CustomFloatingButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  const CustomFloatingButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: Palette.tabColor,
      child: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }
}
