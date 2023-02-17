import 'package:consent_app/src/procedure_chooser_feature/procedure_item_list_view.dart';
import 'package:consent_app/src/procedure_chooser_feature/procedure_item_list_view.i18n.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../settings/settings_view.dart';
import '../video_player_feature/video_item_list_view.dart';

class SummaryView extends StatelessWidget {
  const SummaryView({super.key});

  static const routeName = '/summary';

  @override
  Widget build(BuildContext context) {
    Store store = locator<Store>();
    return Scaffold(
        appBar: AppBar(
          title: Text('Summary'.i18n),
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
              Text('Procedure: ${store.procedure.name}'),
              const SizedBox(height: 10),
              Text('Language: ${store.language}'),
              const SizedBox(height: 10),
              Text('Result: ${store.choices}'),
            ]))
    );
  }
}
