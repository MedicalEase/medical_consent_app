import 'package:flutter/material.dart';

import '../../filename.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        // Glue the SettingsController to the theme selection DropdownButton.
        //
        // When a user selects a theme from the dropdown list, the
        // SettingsController is updated, which rebuilds the MaterialApp.
        child: Column(
          children: [
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
  final database = MyDatabase();

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
        children:  [
          const Text('Please enter a unique identifier for this device'),
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
                  await add_device_identifier(myController.text);
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

  Future<void> add_device_identifier(String name) async {
    await database.into(database.categories).insert(CategoriesCompanion.insert(
          description: name,
        ));

    // Simple select:
    final allCategories = await database.select(database.categories).get();
    print('Categories in database: $allCategories');
  }
}
