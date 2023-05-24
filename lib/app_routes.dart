import 'package:dartboard/pages/local_game_start_page.dart';
import 'package:dartboard/pages/online_game_start_page.dart';
import 'package:dartboard/pages/settings.dart';
import 'package:dartboard/pages/statistics_page.dart';
import 'package:dartboard/service/setup_user_service.dart';
import 'package:dartboard/service/ioc_container.dart';
import 'package:dartboard/widgets/app_bar/custom_app_bar.dart';
import 'package:dartboard/widgets/new_local_without_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

var appRoutes = GoRouter(
  redirect: (BuildContext context, GoRouterState state) {
    if (state.location == '/') {
      return '/game/online/start';
    }
    if (FirebaseAuth.instance.currentUser == null) {
      if (state.location != '/game/local' &&
          state.location != '/game/local/start') {
        return '/sign-in';
      }
    }
    return null;
  },
  initialLocation: '/game/online/start',
  routes: [
    GoRoute(
      name: '/sign-in',
      path: '/sign-in',
      builder: (context, state) {
        return SignInScreen(
          headerBuilder: (context, constraints, _) {
            return NewLocalWithoutSignIn();
          },
          actions: [
            AuthStateChangeAction<SignedIn>((context, state) {
              _navigateToHome(context);
            }),
            AuthStateChangeAction<UserCreated>((context, state) {
              String userId = FirebaseAuth.instance.currentUser!.uid;
              final setupUserController = get<SetupUserService>();
              setupUserController.createCollectionsForUser(userId);

              _navigateToHome(context);
            }),
          ],
        );
      },
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) {
        return ProfileScreen(
          appBar: CustomAppBar(
            title: Text('Profile'),
            context: context,
          ),
          actions: [
            SignedOutAction((context) {
              context.pushReplacementNamed('/sign-in');
            }),
          ],
        );
      },
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
  ],
);

_navigateToHome(BuildContext context) {
  context.go('/game/online/start');
}
