import 'package:consent_app/src/procedure_chooser_feature/procedure_item_list_view.dart';
import 'package:consent_app/src/procedure_chooser_feature/procedure_item_list_view.i18n.dart';
import 'package:consent_app/src/summary_feature/summary_view.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../settings/settings_view.dart';
import '../video_player_feature/video_item_list_view.dart';

class ThankYouView extends StatelessWidget {
  const ThankYouView({super.key});

  static const routeName = '/thankyou';

  @override
  Widget build(BuildContext context) {
    Store store = locator<Store>();
    return Scaffold(
        appBar: AppBar(
          title: Text('ThankYou'.i18n),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                // Navigate to the settings page. If the user leaves and returns
                // to the app after it has been killed while running in the
                // background, the navigation stack is restored.
                Navigator.restorablePushNamed(context, SettingsView.routeName);
              },
            ),
          ],
        ),
        body: Center(
            child: Column(children: [
          Text('Thank you for your participation!'.i18n),
          const SizedBox(height: 40),
          Text('Would you like to fill out a survey?'.i18n),
          const SizedBox(height: 10),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  store.choices.add('survey');
                },
                child: Text('Ok Survey'.i18n),
              ),
              ElevatedButton(
                onPressed: () {
                  store.choices.add('No survey');
                  Navigator.restorablePushNamed(
                    context,
                    SummaryView.routeName,
                  );
                },
                child: Text('No Survey'.i18n),
              )
            ],
          )
        ])));
  }
}
