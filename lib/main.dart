import 'package:dartboard/model/current_score_notifier.dart';
import 'package:dartboard/pages/local_game.dart';
import 'package:dartboard/pages/main_page.dart';
import 'package:dartboard/pages/online_game.dart';
import 'package:dartboard/pages/settings.dart';
import 'package:dartboard/pages/statistics_page.dart';
import 'package:dartboard/widgets/grid_redirect_button.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseUIAuth.configureProviders([EmailAuthProvider()]);

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
        initialRoute: (FirebaseAuth.instance.currentUser == null)
            ? "/sign-in"
            : "/main_page",
        routes: _getAppRoutes(),
      ),
    );
  }

  _getAppRoutes() {
    return {
      '/sign-in': (context) {
        return SignInScreen(
          headerBuilder: (context, constraints, _) {
            return GridRedirectButton(
              routeName: "/game/local",
              text: "New Local Game",
              iconData: Icons.add_box_outlined,
            );
          },
          actions: [
            AuthStateChangeAction<SignedIn>((context, state) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/main_page', (Route<dynamic> route) => false);
            }),
          ],
        );
      },
      '/profile': (context) {
        return ProfileScreen(
          appBar: AppBar(
            title: Text("Profile"),
          ),
          actions: [
            SignedOutAction((context) {
              Navigator.pushReplacementNamed(context, '/sign-in');
            }),
          ],
        );
      },
      '/main_page': (context) {
        return MainPage();
      },
      '/statistics': (context) {
        return StatisticsPage();
      },
      '/settings': (context) {
        return Settings();
      },
      '/game/local': (context) {
        return LocalGame();
      },
      '/game/online': (context) {
        return OnlineGame();
      },
      '/exit': (context) {
        SystemNavigator.pop();
        return Text("Exiting App");
      },
    };
  }
}
