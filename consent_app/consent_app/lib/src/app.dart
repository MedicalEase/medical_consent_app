import 'package:consent_app/src/language_chooser_feature/language_item_list_view.dart';
import 'package:consent_app/src/procedure_chooser_feature/procedure_item_list_view.dart';
import 'package:consent_app/src/summary_feature/summary_view.dart';
import 'package:consent_app/src/video_player_feature/video_item_dataclass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'video_player_feature/video_item_details_view.dart';
import 'video_player_feature/video_item_list_view.dart';
import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.settingsController});

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
        return I18n(
            child: MaterialApp(
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
            splashColor: const Color(0xFFF0F4F5),
            scaffoldBackgroundColor: const Color(0xFFF0F4F5),
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF005EB8),
              secondary: Color(0xFF007F3B),
            ),
            primaryColor: Colors.lightGreen[800],
            fontFamily: 'Frutiger',
            textTheme: const TextTheme(
              displayLarge: TextStyle(
                fontSize: 72.0,
                fontFamily: 'Frutiger',
                fontWeight: FontWeight.w700,
              ),
              titleLarge: TextStyle(
                fontSize: 36.0,
                // color: Colors.green,
                fontFamily: 'Frutiger',
                fontWeight: FontWeight.w700,
              ),
              bodyMedium: TextStyle(
                color: Color(0xFF212B32),
                fontSize: 24.0,
                fontFamily: 'Frutiger',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          darkTheme: ThemeData.dark(),
          themeMode: settingsController.themeMode,
          debugShowCheckedModeBanner: false,
          debugShowMaterialGrid: false,
          // Define a function to handle named routes in order to supporting
          // Flutter web url navigation and deep linking.
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  case VideoItemListView.routeName:
                    return const VideoItemListView();
                  case LanguageListView.routeName:
                    return const LanguageListView();
                  case SettingsView.routeName:
                    return SettingsView(controller: settingsController);
                  case SummaryView.routeName:
                    return SummaryView();
                  case VideoItemDetailsView.routeName:
                    final value = routeSettings.arguments as int;
                    print('VideoItemDetailsView.routeName value: $value');
                    return VideoItemDetailsView(videoId: value);
                  case ProcedureListView.routeName:
                  default:
                    return const ProcedureListView();
                }
              },
            );
          },
        ));
      },
    );
  }
}
