import 'package:dartboard/pages/local_game_start_page.dart';
import 'package:dartboard/pages/main_page.dart';
import 'package:dartboard/pages/online_game_start_page.dart';
import 'package:dartboard/pages/settings.dart';
import 'package:dartboard/pages/statistics_page.dart';
import 'package:dartboard/service/setup_user_service.dart';
import 'package:dartboard/service/ioc_container.dart';
import 'package:dartboard/widgets/new_local_without_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

var appRoutes = GoRouter(
  redirect: (BuildContext context, GoRouterState state) {
    if (FirebaseAuth.instance.currentUser != null) {
      return null;
    } else if (state.location != '/game/local' &&
        state.location != '/game/local/start') {
      return '/sign-in';
    }
  },
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/sign-in',
      builder: (context, state) {
        return SignInScreen(
          headerBuilder: (context, constraints, _) {
            return NewLocalWithoutSignIn();
          },
          actions: [
            AuthStateChangeAction<SignedIn>((context, state) {
              _navigateToMainPage(context);
            }),
            AuthStateChangeAction<UserCreated>((context, state) {
              String userId = FirebaseAuth.instance.currentUser!.uid;
              final setupUserController = get<SetupUserService>();
              setupUserController.createCollectionsForUser(userId);

              _navigateToMainPage(context);
            }),
          ],
        );
      },
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) {
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
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => MainPage(),
    ),
    GoRoute(
      path: '/statistics',
      builder: (context, state) => StatisticsPage(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => Settings(),
    ),
    GoRoute(
      path: '/game/local',
      builder: (context, state) => LocalGameStart(),
    ),
    GoRoute(
      path: '/game/online/start',
      builder: (context, state) => OnlineGameStartPage(),
    ),
    GoRoute(
      path: '/exit',
      builder: (context, state) {
        SystemNavigator.pop();
        return Text("Exiting App");
      },
    ),
  ],
);

_navigateToMainPage(BuildContext context) {
  context.go('/');
}
