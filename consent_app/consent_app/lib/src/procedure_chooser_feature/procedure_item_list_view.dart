import 'package:consent_app/src/language_chooser_feature/language_item_list_view.dart';
import 'package:consent_app/src/video_player_feature/video_item_list_view.dart';
import 'package:flutter/material.dart';
import 'package:i18n_extension/i18n_extension.dart';
import 'procedure_item_list_view.i18n.dart';
import '../../main.dart';
import '../procedure_data.dart';
import '../settings/settings_view.dart';
import 'procedure_item_dataclass.dart';

class ProcedureListView extends StatelessWidget {
  const ProcedureListView({
    super.key,
  });

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    Store store = locator<Store>();
    var items = store.procedures;
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Procedure'.i18n),
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
          final item = store.procedures[index];

          return ListTile(
              title: Text(('Procedure'.i18n) + ' : ${item.name}'),
              leading: CircleAvatar(
                backgroundImage: AssetImage(item.icon),
              ),
              onTap: () {
                store.procedure = item;

                Navigator.restorablePushNamed(
                  context,
                  LanguageListView.routeName,
                  arguments: item.id,
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.arrow_forward),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
