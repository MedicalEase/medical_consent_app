import 'package:consent_app/src/sample_feature/player.dart';
import 'package:consent_app/src/sample_feature/sample_item.dart';
import 'package:consent_app/src/sample_feature/sample_item_list_view.dart';
import 'package:flutter/material.dart';
import 'package:consent_app/src/web_video_player/web_video_player.dart';

class SampleItemDetailsView extends StatelessWidget {
  // In the constructor, require a videoId.
  const SampleItemDetailsView({super.key, required this.videoId});

  // Declare a field that holds the videoId.
  final int videoId;
  static const routeName = '/detail';

  init() {
    print('init');
  }
  @override
  Widget build(BuildContext context) {
    // Use the videoId to create the UI.
    SampleItem item = const SampleItemListView().items[videoId];
    const vidUrl = 'http://commondatastorage.googleapis'
        '.com/gtv-videos-bucket/sample/BigBuckBunny.mp4';
    return Scaffold(
      appBar: AppBar(
        title: Text('hed'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            WebVideoPlayer(key: Key(item.id.toString()),),
            Text(videoId.toString()),
            Text(item.id.toString()),
            const SizedBox(height: 16.0),
            ElevatedButton(
              child: const Text('Next'),
              onPressed: () {
                // When the user taps the button, navigate to the next video.
                // Navigate to the next video.
                Navigator.pushNamed(
                  context,
                  routeName,
                  arguments: videoId + 1,
                );

                // When the user taps the button, navigate back to the first
                // screen by popping the current route off the stack.
                Navigator.restorablePushNamed(
                  context,
                  SampleItemDetailsView.routeName,
                  arguments: videoId + 1,
                );
              },
            ),
            ElevatedButton(
              child: const Text('home'),
              onPressed: () {
                // When the user taps the button, navigate back to the first
                // screen by popping the current route off the stack.
                Navigator.restorablePushNamed(
                  context,
                  SampleItemListView.routeName,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
