import 'dart:io';
import 'package:chat/constants/router.dart';
import 'package:chat/features/auth/auth_respository.dart';
import 'package:chat/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authControllerProvider = Provider((ref) {
  final authRespository = ref.watch(authRespositoryProvider);
  return AuthController(
    authRepository: authRespository,
    ref: ref,
  );
});

final userDataAuthProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider);
  return authController.getUserData();
});

class AuthController {
  final AuthRespository authRepository;
  final ProviderRef ref;

  AuthController({
    required this.authRepository,
    required this.ref,
  });

  void signInWithPhone(BuildContext context, String phoneNumber) {
    authRepository.signInWithPhone(context, phoneNumber);
  }

  Future<void> verifyOTP(
      BuildContext context, String verificationId, String userOTP) async {
    authRepository.verifyOTP(
      context: context,
      verificationId: verificationId,
      userOTP: userOTP,
    );
  }

  void saveUserDataToFirebase(
      BuildContext context, String name, File? profilePic) {
    authRepository.saveUserDataToFirebase(
      context: context,
      ref: ref,
      profileName: name,
      profilePic: profilePic,
    );
  }

  Future<UserModel?> getUserData() async {
    UserModel? user = await authRepository.getCurrentUserData();
    return user;
  }

  Future<void> logout(BuildContext context) async {
    await authRepository.signOut(context);
    if (context.mounted) {
      Navigator.pushNamedAndRemoveUntil(
          context, welcomeRoute, (route) => false);
    }
  }

  Stream<UserModel> userDataByUserId(String userId) {
    return authRepository.userData(userId);
  }
}
