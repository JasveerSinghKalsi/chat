import 'package:chat/theme/palette.dart';
import 'package:flutter/material.dart';

class CustomFloatingButton extends StatelessWidget {
  final IconData icon;
  const CustomFloatingButton({
    super.key,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {},
      backgroundColor: Palette.tabColor,
      child: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }
}
