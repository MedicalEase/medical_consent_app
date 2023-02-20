import 'package:consent_app/src/components/frame.dart';
import 'package:consent_app/src/procedure_chooser_feature/procedure_item_list_view.dart';
import 'package:consent_app/src/procedure_chooser_feature/procedure_item_list_view.i18n.dart';
import 'package:consent_app/src/summary_feature/summary_view.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../settings/settings_view.dart';
import '../video_player_feature/video_item_list_view.dart';

class IntroView extends StatelessWidget {
  const IntroView({super.key});

  static const routeName = '/intro';

  @override
  Widget build(BuildContext context) {
    Store store = locator<Store>();
    return FrameView(
      heading: 'Intro',
      body: Column(children: [
        Text('Made by, XXX with YYYY released 2/feb/2032 VER 0.1!'.i18n),
        const SizedBox(height: 40),
        Text('Thanks to : CCCC'.i18n),
        const SizedBox(height: 10),
        Text('Support and help: contact'.i18n),
        Row(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.restorablePushNamed(
                  context,
                  ProcedureListView.routeName,
                );
              },
              child: Text('Continue'.i18n),
            )
          ],
        )
      ]),
    );
    return Scaffold(
        appBar: AppBar(
          title: Text('Intro'.i18n),
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
          Text('Made by, XXX with YYYY released 2/feb/2032 VER 0.1!'.i18n),
          const SizedBox(height: 40),
          Text('Thanks to : CCCC'.i18n),
          const SizedBox(height: 10),
          Text('Support and help: contact'.i18n),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.restorablePushNamed(
                    context,
                    ProcedureListView.routeName,
                  );                },
                child: Text('Continue'.i18n),
              )
            ],
          )
        ])));
  }
}
