import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:dont_forget/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData.light(useMaterial3: true),
      dark: ThemeData.dark(useMaterial3: true),
      initial: AdaptiveThemeMode.dark,
      builder: (ThemeData light, ThemeData dark) => MaterialApp(
        title: 'Do not forget app',
        theme: light,
        darkTheme: dark,
        home: const HomeScreen(),
      ),
    );
  }
}
