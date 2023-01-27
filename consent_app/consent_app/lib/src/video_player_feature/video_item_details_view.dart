import 'package:consent_app/src/video_player_feature/video_item_dataclass.dart';
import 'package:consent_app/src/video_player_feature/video_item_list_view.dart';
import 'package:consent_app/src/video_player_feature/video_subtitle.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ExplainerAssetVideo extends StatefulWidget {
  final String path;
  final VideoItem item;
  Duration position = const Duration(seconds: 0);

  ExplainerAssetVideo({Key? key, required this.path, required this.item})
      : super(key: key);

  @override
  ExplainerAssetVideoState createState() => ExplainerAssetVideoState();
}

class ExplainerAssetVideoState extends State<ExplainerAssetVideo> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.path);

    _controller.addListener(() {
      print(_controller.value.position);
      setState(() {
        widget.position = _controller.value.position;
      });
    });
    _controller.setLooping(false);
    _controller.initialize().then((_) => setState(() {}));
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: <Widget>[
        Container(
          padding: const EdgeInsets.only(top: 20.0),
        ),
        Container(
          padding: const EdgeInsets.all(20),
          child: AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                VideoPlayer(_controller),
                _ControlsOverlay(controller: _controller, item: widget.item),
                    VideoProgressIndicator(_controller, allowScrubbing: true),
              ],
            ),
          ),
        ),
        (widget.position.inSeconds > 3)
            ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  _controller.dispose();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VideoItemListView(),
                    ),
                  );
                },
                child: const Text('Questions'),
              ),
              ElevatedButton(
                onPressed: () {
                  _controller.dispose();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VideoItemListView(),
                    ),
                  );
                },
                child: const Text('No'),
              ),
              ElevatedButton(
                onPressed: () {
                  _controller.dispose();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VideoItemListView(),
                    ),
                  );
                },
                child: const Text('OK'),
              ),
            ])
            : Container(),
      ]),
    );
  }
}

class _ControlsOverlay extends StatelessWidget {
  const _ControlsOverlay({Key? key, required this.controller, required this
      .item})
      : super(key: key);

  final VideoPlayerController controller;
  final VideoItem item;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 50),
          reverseDuration: const Duration(milliseconds: 200),
          child: controller.value.isPlaying
              ? const SizedBox.shrink()
              : Container(
            color: Colors.black26,
            child: const Center(
              child: Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 100.0,
                semanticLabel: 'Play',
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            controller.value.isPlaying ? controller.pause() : controller.play();
          },
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
              padding: const EdgeInsets.symmetric(
                // Using less vertical padding as the text is also longer
                // horizontally, so it feels like it would need more spacing
                // horizontally (matching the aspect ratio of the video).
                vertical: 12,
                horizontal: 16,
              ),
              child: SubtitleContent(
                controller: controller,
                item: item,
              )),
        ),
      ],
    );
  }
}

class _PlayerVideoAndPopPage extends StatefulWidget {
  @override
  _PlayerVideoAndPopPageState createState() => _PlayerVideoAndPopPageState();
}

class _PlayerVideoAndPopPageState extends State<_PlayerVideoAndPopPage> {
  late VideoPlayerController _videoPlayerController;
  bool startedPlaying = false;

  @override
  void initState() {
    super.initState();

    _videoPlayerController =
        VideoPlayerController.asset('assets/Butterfly-209.mp4');
    _videoPlayerController.addListener(() {
      if (startedPlaying && !_videoPlayerController.value.isPlaying) {
        Navigator.pop(context);
      }
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  Future<bool> started() async {
    await _videoPlayerController.initialize();
    await _videoPlayerController.play();
    startedPlaying = true;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: FutureBuilder<bool>(
          future: started(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.data ?? false) {
              return AspectRatio(
                aspectRatio: _videoPlayerController.value.aspectRatio,
                child: VideoPlayer(_videoPlayerController),
              );
            } else {
              return const Text('waiting for video to load');
            }
          },
        ),
      ),
    );
  }
}

class VideoItemDetailsView extends StatelessWidget {
  // In the constructor, require a videoId.
  const VideoItemDetailsView({super.key, required this.videoId});

  // Declare a field that holds the videoId.
  final int videoId;
  static const routeName = '/detail';

  @override
  Widget build(BuildContext context) {
    // Use the videoId to create the UI.
    VideoItem item = const VideoItemListView().items[videoId];
    return Scaffold(
      appBar: AppBar(
        title: const Text('hed'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(item.path),
            ExplainerAssetVideo(
              key: Key(item.id.toString()),
              path: item.path,
              item: item,
            ),
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
                  VideoItemDetailsView.routeName,
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
                  VideoItemListView.routeName,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
