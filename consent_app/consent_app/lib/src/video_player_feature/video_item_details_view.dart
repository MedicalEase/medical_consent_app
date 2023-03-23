import 'package:consent_app/src/procedure_chooser_feature/procedure_item_list_view.i18n.dart';
import 'package:consent_app/src/summary_feature/summary_view.dart';
import 'package:consent_app/src/thank_you/thank_you.dart';
import 'package:consent_app/src/video_player_feature/video_item_dataclass.dart';
import 'package:consent_app/src/video_player_feature/video_item_list_view.dart';
import 'package:consent_app/src/video_player_feature/video_subtitle.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../main.dart';
import '../components/frame.dart';

goNext(
  BuildContext context,
  int videoId,
  int nextVideoItemId,
  VideoPlayerController videoController,
) {
  // function to go to next video or thank you page
  videoController.dispose();
  Store store = locator<Store>();
  List<VideoItem> items = store.userProcedures.first.videos;
  VideoItem item = items.firstWhere((item) => item.id == videoId);
  if (item.nextVideoItemId == null) {
    Navigator.restorablePushNamed(
      context,
      ThankYouView.routeName,
    );
  } else {
    Navigator.restorablePushNamed(
      context,
      VideoItemDetailsView.routeName,
      arguments: nextVideoItemId,
    );
  }
}

class ExplainerAssetVideo extends StatefulWidget {
  final String path;
  final VideoItem item;
  final VideoPlayerController controller;
  Duration position = const Duration(seconds: 0);

  ExplainerAssetVideo(
      {Key? key,
      required this.path,
      required this.item,
      required this.controller})
      : super(key: key);

  @override
  ExplainerAssetVideoState createState() => ExplainerAssetVideoState();
}

class ExplainerAssetVideoState extends State<ExplainerAssetVideo> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;

    _controller.addListener(() {
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
                VideoProgressIndicator(
                  _controller,
                  allowScrubbing: true,
                  colors: const VideoProgressColors(
                    playedColor: Color(0xFF005EB8),
                    bufferedColor: Color(0xFFF0F4F5),
                    backgroundColor: Color(0xFFD8DDE0),
                  ),
                ),
              ],
            ),
          ),
        ),
        // we show the answer buttons when timer is up & if there's a FAQ video
        continueButton(context),
        PatientChoicesButtons(context),
      ]),
    );
  }

  Widget PatientChoicesButtons(BuildContext context) {
    Store store = locator<Store>();
    return (widget.item.faqVideoItemId != null) &&
            (widget.position.inSeconds > (widget.item.questionAfter ?? 999999))
        ? Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            ElevatedButton(
              onPressed: () {
                _controller.dispose();
                store.choices.add('${widget.item.id} -${widget.item.heading}-Question');
                goNext(context, widget.item.id, widget.item.faqVideoItemId ?? 0,
                    _controller);
              },
              child: Text('Questions'.i18n),
            ),
            ElevatedButton(
              onPressed: () {
                _controller.dispose();
                store.choices.add('${widget.item.id} -${widget.item.heading}-No');
                goNext(context, widget.item.id,
                    widget.item.nextVideoItemId ?? 0, _controller);
              },
              child: Text('No'.i18n),
            ),
            ElevatedButton(
              onPressed: () {
                _controller.dispose();
                store.choices.add('${widget.item.id}-${widget.item.heading}-OK');
                goNext(context, widget.item.id,
                    widget.item.nextVideoItemId ?? 0, _controller);
              },
              child: Text('OK'.i18n),
            ),
            (widget.position.inSeconds >
                    _controller.value.duration.inSeconds -
                        Duration(seconds: 2).inSeconds)
                ? ElevatedButton(
                    onPressed: () {
                      store.choices
                          .add('${widget.item.id}-${widget.item.heading}-replay');
                      _controller.seekTo(Duration(seconds: 0));
                      _controller.play();
                    },
                    child: Text('PLay again'.i18n),
                  )
                : Container(),
          ])
        : Container();
  }

  Widget continueButton(BuildContext context) {
    return (widget.item.faqVideoItemId == null) &&
            (widget.position.inSeconds > (widget.item.questionAfter ?? 999999))
        ? Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            ElevatedButton(
              onPressed: () {
                goNext(context, widget.item.id,
                    widget.item.nextVideoItemId ?? 0, _controller);
              },
              child: Text('Continue'.i18n),
            ),
          ])
        : Container();
  }
}

class _ControlsOverlay extends StatelessWidget {
  const _ControlsOverlay(
      {Key? key, required this.controller, required this.item})
      : super(key: key);

  final VideoPlayerController controller;
  final VideoItem item;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          reverseDuration: const Duration(milliseconds: 200),
          child: (controller.value.position > const Duration(seconds: 1) &&
                  controller.value.position == controller.value.duration)
              ? overlayIcon(Icons.replay, 'Replay')
              : controller.value.isPlaying
                  ? const SizedBox.shrink()
                  : overlayIcon(Icons.play_arrow, 'Play'),
        ),
        GestureDetector(
          onTap: () {
            if (controller.value.position == controller.value.duration) {
              controller.seekTo(const Duration(seconds: 0));
              controller.play();
            }
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

  Container overlayIcon(icon, String semanticLabel) {
    return Container(
      color: Colors.black26,
      child: Center(
        child: Icon(
          icon,
          color: Colors.white,
          size: 200.0,
          semanticLabel: semanticLabel,
        ),
      ),
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
              return Text('waiting for video to load'.i18n);
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
    Store store = locator<Store>();
    List<VideoItem> items = store.userProcedures.first.videos;
    VideoItem item = items.firstWhere((item) => item.id == videoId);
    final videoController = VideoPlayerController.asset(item.path);
    return FrameView(
      heading: '${item.heading}'.i18n,
      admin_pre_action:() => videoController.dispose(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('${item.summary}'.i18n),
            ExplainerAssetVideo(
              key: Key(item.id.toString()),
              path: item.path,
              item: item,
              controller: videoController,
            ),
          locator<Store>().debugMode ?
            Column(
              children: [
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      child: Text('Next'.i18n),
                      onPressed: () {
                        goNext(context, videoId, item.nextVideoItemId ?? 0,
                            videoController);
                      },
                    ),
                    ElevatedButton(
                      child: const Text('video index'),
                      onPressed: () {
                        // When the user taps the button, navigate back to the first
                        // screen by popping the current route off the stack.
                        videoController.dispose();
                        Navigator.restorablePushNamed(
                          context,
                          VideoItemListView.routeName,
                        );
                      },
                    ),
                    ElevatedButton(
                      child: const Text('Summary'),
                      onPressed: () {
                        videoController.dispose();
                        Navigator.restorablePushNamed(
                          context,
                          SummaryView.routeName,
                        );
                      },
                    )
                  ],
                ),
              ],
            ) : Container()
          ],
        ),
      ),
    );
  }
}
