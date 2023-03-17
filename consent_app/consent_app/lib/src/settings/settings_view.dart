import 'package:consent_app/src/intro/intro_video_layout.dart';
import 'package:flutter/material.dart';

import '../../database.dart';
import '../../main.dart';
import '../components/frame.dart';
import 'settings_controller.dart';

class PasswordProtect extends StatefulWidget {
  const PasswordProtect({Key? key}) : super(key: key);
  static const routeName = '/passwordzone';

  @override
  State<PasswordProtect> createState() => _PasswordProtectState();
}

class _PasswordProtectState extends State<PasswordProtect> {
  final myController = TextEditingController();
  final Widget child = Container();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FrameView(
        heading: 'Admin',
        body:

      Column(
      children: [
        const Text('Password'),
        TextFormField(
          controller: myController,
          obscureText: true,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Password',
          ),
        ),
        ElevatedButton(
          onPressed: () {
            var v = myController.value.text;
            print(v);
            checkPassword();
            Navigator.restorablePushNamed(
              context,
              SettingsView.routeName,
            );
          },
          child: const Text('Submit'),
        ),
        ElevatedButton(
          onPressed: () {
            checkPassword();
            Navigator.restorablePushNamed(
              context,
              IntroView.routeName,
            );
          },
          child: const Text('Back'),
        )
      ],
    ),
    );
  }

  void checkPassword() {
    print("check password ${myController.value.text}");
    if (myController.value.text == "flower") {
      locator<Store>().debugMode = true;
      Navigator.restorablePushNamed(
        context,
        SettingsView.routeName,
      );
    } else {
      print("wrong password");
      Navigator.pop(
        context,
      );
    }
  }
}

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
    if (!locator<Store>().debugMode) {
      return const PasswordProtect();
    }
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
                    ElevatedButton(
                      onPressed: () {
                        Navigator.restorablePushNamed(
                            context,
                            IntroView.routeName
                        );
                      },
                      child: const Text('Back'),
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
  bool debug = locator<Store>().debugMode;

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

  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      // Thumb icon when the switch is selected.
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('Debug mode:'),
              Switch(
                thumbIcon: thumbIcon,
                value: debug,
                onChanged: (bool value) {
                  setState(() {
                    debug = value;
                    locator<Store>().debugMode = value;
                    print("debug mode: $value");
                  });
                },
              ),
            ],
          ),
          const Text('Enter new device identifier below. Currently:'),
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
                  await storeDeviceIdentifier(myController.text);
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
    Store store = locator<Store>();
    store.deviceId = name;
    setState(() {});
  }
}
