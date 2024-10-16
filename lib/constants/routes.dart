import 'package:chat/utils/helpers/error_view.dart';
import 'package:chat/utils/helpers/loading_view.dart';
import 'package:chat/views/home_view.dart';
import 'package:chat/views/login/create_profile_view.dart';
import 'package:chat/views/login/login_view.dart';
import 'package:chat/views/login/verify_view.dart';
import 'package:chat/views/login/welcome_view.dart';
import 'package:flutter/material.dart';

const welcomeRoute = '/welcom/';
const loginRoute = '/login/';
const verifyRoute = '/verify/';
const createProfileRoute = '/create-profile/';
const loadingRoute = '/loading/';
const homeRoute = '/home/';
const chatRoute = '/chat/';
const updateRoute = '/update/';
const callRoute = '/call/';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case welcomeRoute:
      return MaterialPageRoute(builder: (context) => const WelcomeView());
    case loginRoute:
      return MaterialPageRoute(builder: (context) => const LoginView());
    case verifyRoute:
      final verificationId = routeSettings.arguments as String;
      return MaterialPageRoute(
        builder: (context) => VerifyView(
          verificationId: verificationId,
        ),
      );
    case createProfileRoute:
      return MaterialPageRoute(builder: (context) => const CreateProfileView());
    case loadingRoute:
      return MaterialPageRoute(builder: (context) => const LoadingView(text: 'Creating Profile',));
    case homeRoute:
      return MaterialPageRoute(builder: (context) => const HomeView());
    default:
      return MaterialPageRoute(builder: (context) => const ErrorView(error: 'An error occured'));
  }
}
