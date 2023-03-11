import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:typeracer_game/screens/create_room_screen.dart';
import 'package:typeracer_game/screens/home_screen.dart';
import 'package:typeracer_game/screens/join_room_screen.dart';

import 'provider/game_state_provider.dart';
import 'screens/game_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  ThemeMode themeMode = ThemeMode.system;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const FlexScheme usedScheme = FlexScheme.mandyRed;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GameStateProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Typeracer Tutorial',
        // Use a predefined FlexThemeData.light() theme for the light theme.
        theme: FlexThemeData.light(
          scheme: FlexScheme.mango,
          surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
          blendLevel: 28,
          subThemesData: const FlexSubThemesData(
            blendOnLevel: 23,
            blendOnColors: false,
            inputDecoratorRadius: 20.0,
          ),
          visualDensity: FlexColorScheme.comfortablePlatformDensity,
          useMaterial3: true,
          swapLegacyOnMaterial3: true,
          // To use the playground font, add GoogleFonts package and uncomment
          // fontFamily: GoogleFonts.notoSans().fontFamily,
        ),
        darkTheme: FlexThemeData.dark(
          scheme: FlexScheme.mango,
          surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
          blendLevel: 15,
          subThemesData: const FlexSubThemesData(
            blendOnLevel: 20,
            inputDecoratorRadius: 20.0,
          ),
          visualDensity: FlexColorScheme.comfortablePlatformDensity,
          useMaterial3: true,
          swapLegacyOnMaterial3: true,
          // To use the Playground font, add GoogleFonts package and uncomment
          // fontFamily: GoogleFonts.notoSans().fontFamily,
        ),
        // Use the above dark or light theme based on active themeMode.
        themeMode: themeMode,
        initialRoute: '/',
        routes: {
          '/': (context) => const HomeScreen(),
          '/create-room': (context) => const CreateRoomScreen(),
          '/join-room': (context) => const JoinRoomScreen(),
          '/game-screen': (context) => const GameScreen(),
        },
      ),
    );
  }
}
