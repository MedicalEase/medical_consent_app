import 'package:consent_app/src/procedure_chooser_feature/procedure_item_list_view.i18n.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../settings/settings_controller.dart';
import '../settings/settings_service.dart';
import '../settings/settings_view.dart';

class FrameView extends StatefulWidget {
  const FrameView({
    super.key,
    required this.heading,
    required this.body,
    this.admin_pre_action,
  });

  final String heading;
  final Widget body;
  final Function? admin_pre_action;

  @override
  State<FrameView> createState() => _FrameViewState();
}

class _FrameViewState extends State<FrameView> {
  bool debug = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: locator<Store>().debugMode,
        title: Text('${widget.heading}'.i18n),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () async {
              if (widget.admin_pre_action != null) {
                widget.admin_pre_action!();
              }
              final settingsController = SettingsController(SettingsService());
              await settingsController.loadSettings();
              var store = locator<Store>();
              if (store.debugMode == false) {
                Navigator.restorablePushNamed(
                  context,
                  PasswordProtect.routeName,
                );
              }
              debug = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        SettingsView(controller: settingsController)),
              );
              setState(() {
                debug = debug;
              });
            },
          ),
        ],
      ),
      body: widget.body,
    );
  }
}
