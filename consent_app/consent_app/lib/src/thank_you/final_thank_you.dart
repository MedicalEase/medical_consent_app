import 'package:consent_app/src/intro/intro.dart';
import 'package:consent_app/src/procedure_chooser_feature/procedure_item_list_view.dart';
import 'package:consent_app/src/procedure_chooser_feature/procedure_item_list_view.i18n.dart';
import 'package:consent_app/src/summary_feature/summary_view.dart';
import 'package:consent_app/src/survey/survey.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../settings/settings_view.dart';
import '../video_player_feature/video_item_list_view.dart';

class FinalThankYou extends StatelessWidget {
  const FinalThankYou({super.key});

  static const routeName = '/Finalthankyou';

  @override
  Widget build(BuildContext context) {
    Store store = locator<Store>();
    return Scaffold(
        appBar: AppBar(
          title: Text('FiNAL Thank You'.i18n),
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
          Text('Final Thank you for your participation!'.i18n),
          const SizedBox(height: 40),
          const SizedBox(height: 10),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.restorablePushNamed(
                    context,
                    SummaryView.routeName,
                  );
                },
                child: Text('Ok Done'.i18n),
              ),
            ],
          )
        ])));
  }
}
