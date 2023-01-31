import 'package:consent_app/src/language_chooser_feature/language_item_list_view.dart';
import 'package:consent_app/src/video_player_feature/video_item_list_view.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../settings/settings_view.dart';
import 'procedure_item_dataclass.dart';

class ProcedureListView extends StatelessWidget {
  const ProcedureListView({
    super.key,
    this.items = content,
  });

  static const content = [
    Procedure(0, 'OGD', []),
    Procedure(1, 'Flexible Sigmoidoscopy', []),
    Procedure(2, 'Colonoscopy', []),
  ];
  static const routeName = '/';
  final List<Procedure> items;

  @override
  Widget build(BuildContext context) {
    Store store = locator<Store>();
    print(store.procedure);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Procedure'),
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

      // To work with lists that may contain a large number of items, it’s best
      // to use the ListView.builder constructor.
      //
      // In contrast to the default ListView constructor, which requires
      // building all Widgets up front, the ListView.builder constructor lazily
      // builds Widgets as they’re scrolled into view.
      body: ListView.builder(
        // Providing a restorationId allows the ListView to restore the
        // scroll position when a user leaves and returns to the app after it
        // has been killed while running in the background.
        restorationId: 'ProcedureListView',
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          final item = items[index];

          return ListTile(
              title: Text('Procedure: ${item.name}'),
              leading: const CircleAvatar(
                // Display the Flutter Logo image asset.
                foregroundImage: AssetImage('assets/images/flutter_logo.png'),
              ),
              onTap: () {
                // Navigate to the details page. If the user leaves and returns to
                // the app after it has been killed while running in the
                // background, the navigation stack is restored.
                store.procedure = item.name;

                Navigator.restorablePushNamed(
                  context,
                  LanguageListView.routeName,
                  arguments: item.id,
                );
              });
        },
      ),
    );
  }
}
