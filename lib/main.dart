import 'package:dartboard/board/dart_board.dart';
import 'package:dartboard/current_score_notifier.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
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
              secondary: Color(0xffac3306),
              secondaryContainer: Color(0xffffdbcf),
              tertiary: Color(0xfffdd877),
              tertiaryContainer: Color(0xffb59538),
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
            // To use the playground font, add GoogleFonts package and uncomment
            // fontFamily: GoogleFonts.notoSans().fontFamily,
          ),
          darkTheme: FlexThemeData.dark(
            colors: const FlexSchemeColor(
              primary: Color(0xff8bc34a),
              primaryContainer: Color(0xffb7dc94),
              secondary: Color(0xffee5444),
              secondaryContainer: Color(0xffc36142),
              tertiary: Color(0xffd5a42e),
              tertiaryContainer: Color(0xffffd682),
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
            swapLegacyOnMaterial3: true,
            // To use the Playground font, add GoogleFonts package and uncomment
            // fontFamily: GoogleFonts.notoSans().fontFamily,
          ),
          themeMode: ThemeMode.system,
          home: DartBoard(),
        ));
  }
}
