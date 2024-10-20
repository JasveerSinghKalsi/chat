import 'package:chat/constants/router.dart';
import 'package:chat/theme/palette.dart';
import 'package:chat/utils/widgets/custom_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                'Welcome to Chat',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height / 9),
              Image.asset(
                'assets/images/profileBackground.png',
                color: Palette.tabColor,
                scale: 2,
              ),
              SizedBox(height: size.height / 9),
              Padding(
                padding: const EdgeInsets.all(16),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      const TextSpan(
                          text: 'Read our',
                          style: TextStyle(color: Colors.grey)),
                      TextSpan(
                          text: ' Privacy Policy',
                          style: const TextStyle(color: Palette.tabColor),
                          recognizer: TapGestureRecognizer()..onTap = () {}),
                      const TextSpan(
                          text:
                              '. Tap "Agree and Continue" to accept the Terms & Conditions.',
                          style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomButton(
                  text: 'Agree and Continue',
                  onPressed: () {
                    Navigator.pushNamed(context, loginRoute);
                  },
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
