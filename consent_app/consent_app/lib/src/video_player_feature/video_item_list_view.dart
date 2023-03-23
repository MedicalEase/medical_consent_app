import 'package:flutter/material.dart';

import '../../main.dart';
import '../settings/settings_view.dart';
import 'video_item_details_view.dart';

class VideoItemListView extends StatelessWidget {
  const VideoItemListView({
    super.key,
  });


  static const routeName = 'videolist';

  @override
  Widget build(BuildContext context) {
        Store store = locator<Store>();

    var items = store.userProcedures.first.videos;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Clips'),
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
        restorationId: 'VideoItemListView',
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          final item = items[index];

          return ListTile(
              title: Text('Video ${item.heading} '),
              leading: const CircleAvatar(
                // Display the Flutter Logo image asset.
                foregroundImage: AssetImage('assets/images/flutter_logo.png'),
              ),
              onTap: () {
                // Navigate to the details page. If the user leaves and returns to
                // the app after it has been killed while running in the
                // background, the navigation stack is restored.
                Navigator.restorablePushNamed(
                  context,
                  VideoItemDetailsView.routeName,
                  arguments: item.id,
                );
              });
        },
      ),
    );
  }
}
