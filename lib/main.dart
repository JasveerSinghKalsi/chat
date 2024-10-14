import 'package:chat/constants/routes.dart';
import 'package:chat/firebase_options.dart';
import 'package:chat/theme/palette.dart';
import 'package:chat/views/calls/calling_view.dart';
import 'package:chat/views/home_view.dart';
import 'package:chat/views/chats/conversation_view.dart';
import 'package:chat/views/updates/update.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WhatsApp Clone',
      theme: ThemeData.dark(
        useMaterial3: true,
      ).copyWith(
        scaffoldBackgroundColor: Palette.scaffoldBackgroundColor,
        appBarTheme: const AppBarTheme(
            centerTitle: false,
            color: Palette.appBarColor,
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            iconTheme: IconThemeData(color: Colors.white)),
      ),
      home: const HomePage(),
      routes: {
        chatRoute: (context) => const ConversationView(),
        updateRoute: (context) => const Update(),
        callRoute: (context) => const CallingView(),
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeView();
  }
}
