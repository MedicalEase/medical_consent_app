import 'package:flutter/material.dart';

import '../settings/settings_view.dart';
import 'video_item_dataclass.dart';
import 'video_item_details_view.dart';

class VideoItemListView extends StatelessWidget {
  const VideoItemListView({
    super.key,
    this.items = content,
  });

  static const content = [
    VideoItem(0, 'assets/video/1-2-intro.mp4', [
      SubtitleLine(1, 'Hello', Duration(seconds: 0), Duration(seconds: 5)),
      SubtitleLine(2, 'World', Duration(seconds: 5), Duration(seconds: 10)),
    ]),
    VideoItem(1, 'assets/video/2-3-ogd_explanation.mp4', [
      SubtitleLine(1, 'Hello', Duration(seconds: 0), Duration(seconds: 5)),
      SubtitleLine(2, 'World', Duration(seconds: 5), Duration(seconds: 10)),
    ]),
    VideoItem(2, 'assets/video/3-4-ogd_question.mp4', [
      SubtitleLine(1, 'Hello', Duration(seconds: 0), Duration(seconds: 5)),
      SubtitleLine(2, 'World', Duration(seconds: 5), Duration(seconds: 10)),
    ]),
    VideoItem(3, 'assets/video/4-5-sedation_question.mp4', [
      SubtitleLine(1, 'Hello', Duration(seconds: 0), Duration(seconds: 5)),
      SubtitleLine(2, 'World', Duration(seconds: 5), Duration(seconds: 10)),
    ]),
  ];
  static const routeName = 'videolist';

  final List<VideoItem> items;

  @override
  Widget build(BuildContext context) {
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
              title: Text('Video ${item.id}'),
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
