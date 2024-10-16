import 'package:chat/constants/routes.dart';
import 'package:chat/firebase_options.dart';
import 'package:chat/services/auth/auth_controller.dart';
import 'package:chat/theme/theme_data.dart';
import 'package:chat/utils/widgets/error_view.dart';
import 'package:chat/utils/widgets/loading_view.dart';
import 'package:chat/views/home_view.dart';
import 'package:chat/views/login/welcome_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'WhatsApp Clone',
        theme: themeData,
        home: const HomePage(),
        onGenerateRoute: (settings) {
          return generateRoute(settings);
        },
      ),
    ),
  );
}

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(userDataAuthProvider).when(
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
        );
  }
}
