import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/core/configs/routes/named_routes.dart';
import 'package:movie_app/core/configs/routes/routes.dart';
import 'package:movie_app/core/configs/themes/custom_theme.dart';
import 'package:movie_app/l10n/l10n.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final routeObserver =
        Get.put<RouteObserver>(RouteObserver<PageRoute<dynamic>>());

    return GetMaterialApp(
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      themeMode: ThemeMode.dark,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      initialRoute: NamedRoutes.navigationPage,
      navigatorObservers: [routeObserver],
      getPages: Routes.page.map((page) => page).toList(),
    );
  }
}
