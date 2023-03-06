import 'package:consent_app/src/procedure_chooser_feature/procedure_item_list_view.i18n.dart';
import 'package:flutter/material.dart';

import '../settings/settings_view.dart';

class FrameView extends StatelessWidget {
  const FrameView({
    super.key,
    required this.heading,
    required this.body,
    this.admin_pre_action,
  }
  );

  final String heading;
  final Widget body;
  final Function? admin_pre_action;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('${heading}'.i18n),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              if (admin_pre_action != null) {
                admin_pre_action!();
              }
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
