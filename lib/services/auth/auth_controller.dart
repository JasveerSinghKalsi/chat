import 'dart:io';

import 'package:chat/constants/routes.dart';
import 'package:chat/services/auth/auth_respository.dart';
import 'package:chat/services/models/user_model.dart';
import 'package:chat/utils/widgets/show_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authControllerProvider = Provider((ref) {
  final authRespository = ref.watch(authRespositoryProvider);
  return AuthController(
    authRespository: authRespository,
    ref: ref,
  );
});

final userDataAuthProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider);
  return authController.getUserData();
});

class AuthController {
  final AuthRespository authRespository;
  final ProviderRef ref;

  AuthController({
    required this.authRespository,
    required this.ref,
  });

  void signInWithPhone(BuildContext context, String phoneNumber) {
    authRespository.signInWithPhone(
      context,
      phoneNumber,
    );
  }

  Future<void> verifyOTP(
      BuildContext context, String verificationId, String userOTP) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: userOTP,
      );
      await authRespository.auth.signInWithCredential(credential);

      bool doesProfileExist = await authRespository.doesUserProfileExist();

      if (context.mounted) {
        if (doesProfileExist) {
          Navigator.pushNamedAndRemoveUntil(
              context, homeRoute, (route) => false);
        } else {
          Navigator.pushNamedAndRemoveUntil(
              context, createProfileRoute, (route) => false);
        }
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context: context, content: e.toString());
      }
    }
  }

  void saveUserDataToFirebase(
      BuildContext context, String name, File? profilePic) {
    authRespository.saveUserDataToFirebase(
      context: context,
      profileName: name,
      profilePic: profilePic,
      ref: ref,
    );
  }

  Future<UserModel?> getUserData() async {
    UserModel? user = await authRespository.getCurrentUserData();
    return user;
  }

  Future<void> logout(BuildContext context) async {
    await authRespository.signOut(context);
    if (context.mounted) {
      Navigator.pushNamedAndRemoveUntil(
          context, welcomeRoute, (route) => false);
    }
  }
}
