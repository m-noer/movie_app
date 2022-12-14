import 'package:flutter/material.dart';
import 'package:movie_app/core/configs/themes/custom_theme.dart';
import 'package:movie_app/l10n/l10n.dart';
import 'package:movie_app/presentation/pages/navigation_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      themeMode: ThemeMode.system,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const NavigationPage(),
    );
  }
}
