import 'package:dartboard/pages/local_game.dart';
import 'package:dartboard/pages/main_page.dart';
import 'package:dartboard/pages/online_game.dart';
import 'package:dartboard/pages/settings.dart';
import 'package:dartboard/pages/statistics_page.dart';
import 'package:dartboard/widgets/new_local_without_sign_in.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

var appRoutes = <String, WidgetBuilder>{
  '/sign-in': (context) {
    return SignInScreen(
      headerBuilder: (context, constraints, _) {
        return NewLocalWithoutSignIn();
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