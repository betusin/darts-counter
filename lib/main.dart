import 'package:dartboard/model/current_score_notifier.dart';
import 'package:dartboard/pages/main_page.dart';
import 'package:dartboard/pages/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CurrentScoreNotifier>(
      create: (_) => CurrentScoreNotifier(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: (FirebaseAuth.instance.currentUser != null)
            ? MainPage()
            : RegisterPage(),
      ),
    );
  }
}
