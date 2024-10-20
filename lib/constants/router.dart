import 'package:chat/features/select_contact/select_contacts_view.dart';
import 'package:chat/utils/helpers/error_view.dart';
import 'package:chat/features/chat/conversation_view.dart';
import 'package:chat/home_view.dart';
import 'package:chat/features/auth/views/create_profile_view.dart';
import 'package:chat/features/auth/views/login_view.dart';
import 'package:chat/features/auth/views/verify_view.dart';
import 'package:chat/features/auth/views/welcome_view.dart';
import 'package:flutter/material.dart';

const welcomeRoute = '/welcom/';
const loginRoute = '/login/';
const verifyRoute = '/verify/';
const createProfileRoute = '/create-profile/';
const loadingRoute = '/loading/';
const selectContactsRoute = '/select-contacts/';
const homeRoute = '/home/';
const conversationRoute = '/conversation/';
const updateRoute = '/update/';
const callRoute = '/call/';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case welcomeRoute:
      return MaterialPageRoute(builder: (context) => const WelcomeView());
    case loginRoute:
      return MaterialPageRoute(builder: (context) => const LoginView());
    case verifyRoute:
      final verificationId = settings.arguments as String;
      return MaterialPageRoute(
        builder: (context) => VerifyView(
          verificationId: verificationId,
        ),
      );
    case createProfileRoute:
      return MaterialPageRoute(builder: (context) => const CreateProfileView());
    case selectContactsRoute:
      return MaterialPageRoute(
          builder: (context) => const SelectContactsView());
    case homeRoute:
      return MaterialPageRoute(builder: (context) => const HomeView());
    case conversationRoute:
      final arguments = settings.arguments as Map<String, dynamic>;
      final name = arguments['name'];
      final uid = arguments['uid'];
      final profilePic = arguments['profilePic'];
      final isGroupChat = arguments['isGroupChat'];
      return MaterialPageRoute(
          builder: (context) => ConversationView(
                name: name,
                uid: uid,
                profilePic: profilePic,
                isGroupChat: isGroupChat,
              ));
    default:
      return MaterialPageRoute(
          builder: (context) => const ErrorView(error: 'An error occured'));
  }
}
