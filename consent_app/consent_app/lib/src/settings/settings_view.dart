import 'package:flutter/material.dart';

import '../../database.dart';
import '../components/frame.dart';
import 'settings_controller.dart';

/// Displays the various settings that can be customized by the user.
///
/// When a user changes a setting, the SettingsController is updated and
/// Widgets that listen to the SettingsController are rebuilt.
class SettingsView extends StatelessWidget {
  const SettingsView({super.key, required this.controller});

  static const routeName = '/settings';

  final SettingsController controller;

  @override
  Widget build(BuildContext context) {
    return FrameView(
      heading: 'Admin',
      body: DefaultTextStyle(
        style: Theme.of(context).textTheme.bodyMedium!,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const Text('Theme'),
                    DropdownButton<ThemeMode>(
                      // Read the selected themeMode from the controller
                      value: controller.themeMode,
                      // Call the updateThemeMode method any time the user selects a theme.
                      onChanged: controller.updateThemeMode,
                      items: const [
                        DropdownMenuItem(
                          value: ThemeMode.system,
                          child: Text('System Theme'),
                        ),
                        DropdownMenuItem(
                          value: ThemeMode.light,
                          child: Text('Light Theme'),
                        ),
                        DropdownMenuItem(
                          value: ThemeMode.dark,
                          child: Text('Dark Theme'),
                        )
                      ],
                    ),
                    const SetIdentifierForm(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// Create a Form widget.
class SetIdentifierForm extends StatefulWidget {
  const SetIdentifierForm({super.key});

  @override
  SetIdentifierFormState createState() {
    return SetIdentifierFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class SetIdentifierFormState extends State<SetIdentifierForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final myController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String deviceId = 'not set';

  @override
  initState() {
    getSetting("deviceId").then((result) {
      print("result: $result");
      deviceId = result;
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
              'Please enter a unique identifier for this device, currently:'),
          Text(deviceId),
          TextFormField(
            controller: myController,
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty || value.length < 5) {
                return 'Please enter an identifier for this device at least '
                    '5 characters long';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () async {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  await storeDeviceIdentifier(myController.text, );
                  // Load the user's preferred theme while the splash screen is displayed.
                  // This prevents a sudden theme change when the app is first displayed.

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Identifier Updated')),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> storeDeviceIdentifier(String name) async {
    var deviceName = Setting(
      name: 'deviceId',
      value: name,
    );
    upsertSetting(deviceName);
    deviceId = name;
  setState(() {

  });
  }
}
