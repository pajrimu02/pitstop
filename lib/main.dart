import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'data/app_settings.dart';
import 'screens/auth/login_screen.dart';

void main() {
  runApp(const PitStopApp());
}

class PitStopApp extends StatelessWidget {
  const PitStopApp({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryRed = Color(0xFFB71C1C);

    return ValueListenableBuilder<ThemeMode>(
      valueListenable: AppSettings.themeMode,
      builder: (context, currentMode, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'PitStop',
          themeMode: currentMode,
          theme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.light,
            scaffoldBackgroundColor: const Color(0xFFF7F7F7),
            textTheme: GoogleFonts.poppinsTextTheme(),
            colorScheme: ColorScheme.fromSeed(
              seedColor: primaryRed,
              primary: primaryRed,
              brightness: Brightness.light,
            ),
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              elevation: 0,
            ),
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
            scaffoldBackgroundColor: const Color(0xFF121212),
            textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
            colorScheme: ColorScheme.fromSeed(
              seedColor: primaryRed,
              primary: primaryRed,
              brightness: Brightness.dark,
            ),
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFF1E1E1E),
              elevation: 0,
            ),
          ),
          home: const LoginScreen(),
        );
      },
    );
  }
}