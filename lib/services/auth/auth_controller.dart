import 'dart:io';

import 'package:chat/services/auth/auth_respository.dart';
import 'package:chat/services/models/user_model.dart';
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

  void verifyOTP(BuildContext context, String verificationId, String userOTP) {
    authRespository.verifyOTP(
      context: context,
      verificationId: verificationId,
      userOTP: userOTP,
    );
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
}
