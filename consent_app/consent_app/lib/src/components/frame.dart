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
    this.showSettings = false,
  });

  final String heading;
  final Widget body;
  final bool showSettings;

  @override
  State<FrameView> createState() => _FrameViewState();
}

class _FrameViewState extends State<FrameView> {
  bool debug = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffF1F4F5),
        automaticallyImplyLeading: locator<Store>().debugMode,
        elevation: 0,
        title: Text(widget.heading, style: const TextStyle(color: Colors.black)),
        actions: [
          (widget.showSettings)?  IconButton(
        icon: const Icon(Icons.settings, color: Colors.blue),
        onPressed: () async {
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
      ): Container() ,

        ],
      ),
      body: widget.body,
    );
  }
}
