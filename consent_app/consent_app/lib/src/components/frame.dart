import 'package:consent_app/src/procedure_chooser_feature/procedure_item_list_view.dart';
import 'package:consent_app/src/procedure_chooser_feature/procedure_item_list_view.i18n.dart';
import 'package:consent_app/src/summary_feature/summary_view.dart';
import 'package:consent_app/src/survey/survey.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../settings/settings_view.dart';

class FrameView extends StatelessWidget {
  const FrameView({
    super.key,
    required this.heading,
    required this.body,
  });

  final String heading;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    Store store = locator<Store>();

    return Scaffold(
      appBar: AppBar(
        title: Text('${heading}'.i18n),
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
      body: body,
    );
  }
}
