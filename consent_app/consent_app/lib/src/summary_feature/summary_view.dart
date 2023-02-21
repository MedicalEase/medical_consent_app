import 'package:consent_app/src/intro/intro.dart';
import 'package:consent_app/src/procedure_chooser_feature/procedure_item_list_view.dart';
import 'package:consent_app/src/procedure_chooser_feature/procedure_item_list_view.i18n.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../components/frame.dart';
import '../settings/settings_view.dart';
import '../video_player_feature/video_item_list_view.dart';

class SummaryView extends StatelessWidget {
  const SummaryView({super.key});

  static const routeName = '/summary';

  @override
  Widget build(BuildContext context) {
    Store store = locator<Store>();
    return FrameView(
        heading: 'Summary',
        body: Center(
            child: Column(children: [
          Text('Procedure: ${store.procedure.name}'),
          const SizedBox(height: 10),
          Text('Language: ${store.language}'),
          const SizedBox(height: 10),
          Text('Result: ${store.choices}'),
          ElevatedButton(
            onPressed: () {
              Navigator.restorablePushNamed(
                context,
                IntroView.routeName,
              );
            },
            child: Text('Restart'.i18n),
          )
        ])));
  }
}
