import 'package:dartboard/model/current_score_notifier.dart';
import 'package:dartboard/pages/main_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
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
          theme: FlexThemeData.light(
            colors: const FlexSchemeColor(
              primary: Color(0xff8bc34a),
              primaryContainer: Color(0xffb7dc94),
              secondary: Color(0xffda3420),
              secondaryContainer: Color(0xffffdbcf),
              tertiary: Color(0xfffeeec4),
              tertiaryContainer: Color(0xffe4c26b),
              appBarColor: Color(0xffffdbcf),
              error: Color(0xffb00020),
            ),
            surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
            blendLevel: 9,
            subThemesData: const FlexSubThemesData(
              blendOnLevel: 10,
              blendOnColors: false,
            ),
            visualDensity: FlexColorScheme.comfortablePlatformDensity,
          ),
          darkTheme: FlexThemeData.dark(
            colors: const FlexSchemeColor(
              primary: Color(0xff8bc34a),
              primaryContainer: Color(0xffb7dc94),
              secondary: Color(0xffee5444),
              secondaryContainer: Color(0xffc36142),
              tertiary: Color(0xffedd9a7),
              tertiaryContainer: Color(0xffc09c42),
              appBarColor: Color(0xffc36142),
              error: Color(0xffcf6679),
            ),
            surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
            blendLevel: 15,
            subThemesData: const FlexSubThemesData(
              blendOnLevel: 20,
              appBarBackgroundSchemeColor: SchemeColor.primary,
            ),
            visualDensity: FlexColorScheme.comfortablePlatformDensity,
          ),
          themeMode: ThemeMode.system,
          home: MainPage(),
        ));
  }
}
