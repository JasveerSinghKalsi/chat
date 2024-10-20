import 'package:chat/constants/router.dart';
import 'package:chat/firebase_options.dart';
import 'package:chat/features/auth/auth_controller.dart';
import 'package:chat/theme/theme_data.dart';
import 'package:chat/utils/helpers/error_view.dart';
import 'package:chat/utils/helpers/loading_view.dart';
import 'package:chat/home_view.dart';
import 'package:chat/features/auth/views/welcome_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WhatsApp Clone',
      theme: themeData,
      onGenerateRoute: (settings) => generateRoute(settings),
      home: ref.watch(userDataAuthProvider).when(
            data: (user) {
              if (user == null) {
                return const WelcomeView();
              } else {
                return const HomeView();
              }
            },
            error: (err, trace) {
              return ErrorView(error: err.toString());
            },
            loading: () => const LoadingView(),
          ),
    );
  }
}
