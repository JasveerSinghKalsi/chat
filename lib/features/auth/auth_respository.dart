import 'dart:io';

import 'package:chat/constants/router.dart';
import 'package:chat/models/user_model.dart';
import 'package:chat/features/storage/firebase_storage_repository.dart';
import 'package:chat/utils/helpers/show_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRespositoryProvider = Provider((ref) => AuthRespository(
      auth: FirebaseAuth.instance,
      firestore: FirebaseFirestore.instance,
    ));

class AuthRespository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  AuthRespository({
    required this.auth,
    required this.firestore,
  });

  void signInWithPhone(BuildContext context, String phoneNumber) async {
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
        },
        verificationFailed: (e) {
          throw Exception(e.message);
        },
        codeSent: ((String verificationId, int? resendToken) async {
          Navigator.pushNamed(
            context,
            verifyRoute,
            arguments: verificationId,
          );
        }),
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } on FirebaseAuthException catch (e) {
      if (context.mounted) showSnackBar(context: context, content: e.message!);
    }
  }

  void verifyOTP({
    required BuildContext context,
    required String verificationId,
    required String userOTP,
  }) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: userOTP,
      );
      await auth.signInWithCredential(credential);

      bool profileExists = await _doesUserProfileExist();

      if (context.mounted) {
        if (profileExists) {
          Navigator.pushNamedAndRemoveUntil(
              context, homeRoute, (route) => false);
        } else {
          Navigator.pushNamedAndRemoveUntil(
              context, createProfileRoute, (route) => false);
        }
      }
    } on FirebaseAuthException catch (e) {
      if (context.mounted) showSnackBar(context: context, content: e.message!);
    }
  }

  Future<bool> _doesUserProfileExist() async {
    final uid = auth.currentUser?.uid;
    if (uid != null) {
      final userDoc = await firestore.collection('users').doc(uid).get();
      return userDoc.exists;
    }
    return false;
  }

  void saveUserDataToFirebase({
    required BuildContext context,
    required ProviderRef ref,
    required String profileName,
    required File? profilePic,
  }) async {
    try {
      String uid = auth.currentUser!.uid;
      String photoUrl =
          'https://png.pngitem.com/pimgs/s/649-6490124_katie-notopoulos-katienotopoulos-i-write-about-tech-round.png';
      if (profilePic != null) {
        photoUrl = await ref
            .read(firebaseStorageRepositoryProvider)
            .storeFileToFirebase('profilePic/$uid', profilePic);
      }
      var user = UserModel(
        name: profileName,
        uid: uid,
        profilePic: photoUrl,
        phoneNumber: auth.currentUser!.phoneNumber!,
        isOnline: true,
      );
      await firestore.collection('users').doc(uid).set(user.toMap());
      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(context, homeRoute, (route) => false);
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context: context, content: e.toString());
      }
    }
  }

  Future<UserModel?> getCurrentUserData() async {
    var userData =
        await firestore.collection('users').doc(auth.currentUser?.uid).get();
    UserModel? user;
    if (userData.data() != null) {
      user = UserModel.fromMap(userData.data()!);
    }
    return user;
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await auth.signOut();
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context: context, content: e.toString());
      }
    }
  }

  Stream<UserModel> userData(String userId) {
    return firestore.collection('users').doc(userId).snapshots().map(
          (event) => UserModel.fromMap(event.data()!),
        );
  }
}
