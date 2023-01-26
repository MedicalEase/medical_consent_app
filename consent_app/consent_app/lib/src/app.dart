import 'package:consent_app/src/language_chooser_feature/language_item_list_view.dart';
import 'package:consent_app/src/procedure_chooser_feature/procedure_item_list_view.dart';
import 'package:consent_app/src/video_player_feature/video_item_dataclass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'video_player_feature/video_item_details_view.dart';
import 'video_player_feature/video_item_list_view.dart';
import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    // Glue the SettingsController to the MaterialApp.
    //
    // The AnimatedBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return AnimatedBuilder(
      animation: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          // Providing a restorationScopeId allows the Navigator built by the
          // MaterialApp to restore the navigation stack when a user leaves and
          // returns to the app after it has been killed while running in the
          // background.
          restorationScopeId: 'app',

          // Provide the generated AppLocalizations to the MaterialApp. This
          // allows descendant Widgets to display the correct translations
          // depending on the user's locale.
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'), // English, Greek, Turkish
            Locale('gr'), // English, Greek, Turkish
            Locale('tr'), // English, Greek, Turkish
          ],

          // Use AppLocalizations to configure the correct application title
          // depending on the user's locale.
          //
          // The appTitle is defined in .arb files found in the localization
          // directory.
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,

          // Define a light and dark color theme. Then, read the user's
          // preferred ThemeMode (light, dark, or system default) from the
          // SettingsController to display the correct theme.
          theme: ThemeData(
            // primaryColor: Colors.lightGreen[800],
            // todo define real styles here
            fontFamily: 'Frutiger',
            textTheme: const TextTheme(
              displayLarge: TextStyle(
                fontSize: 72.0,
                fontWeight: FontWeight.w700,
              ),
              titleLarge: TextStyle(
                fontSize: 36.0,
                fontWeight: FontWeight.w700,
              ),
              bodyMedium: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          darkTheme: ThemeData.dark(),
          themeMode: settingsController.themeMode,

          // Define a function to handle named routes in order to support
          // Flutter web url navigation and deep linking.
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                print('routeSettings.name: ${routeSettings.name}');
                switch (routeSettings.name) {
                  case LanguageListView.routeName:
                    return LanguageListView();
                  case ProcedureListView.routeName:
                    return ProcedureListView();
                  case SettingsView.routeName:
                    return SettingsView(controller: settingsController);
                  case VideoItemDetailsView.routeName:
                    final value = routeSettings.arguments as int;
                    print('value: $value');
                    return VideoItemDetailsView(videoId: value);
                  case VideoItemListView.routeName:
                  default:
                    return const VideoItemListView();
                }
              },
            );
          },
        );
      },
    );
  }
}
