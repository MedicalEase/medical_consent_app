import 'package:consent_app/src/web_video_player/web_video_control.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:video_player/video_player.dart';

class WebVideoPlayer extends StatefulWidget {
  const WebVideoPlayer({Key? key, required this.path}) : super(key: key);

  final String path;
  @override
  _WebVideoPlayerState createState() => _WebVideoPlayerState();
}

class _WebVideoPlayerState extends State<WebVideoPlayer> {
  late FlickManager flickManager;

  @override
  void initState() {
    print('initState');
    print(widget.path);

    super.initState();
    flickManager = FlickManager(
      videoPlayerController:
          VideoPlayerController.asset(widget.path),
    );
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: ObjectKey(flickManager),
      onVisibilityChanged: (visibility) {
        if (visibility.visibleFraction == 0 && this.mounted) {
          flickManager.flickControlManager?.autoPause();
        } else if (visibility.visibleFraction == 1) {
          flickManager.flickControlManager?.autoResume();
        }
      },
      child: FlickVideoPlayer(
        flickManager: flickManager,
        flickVideoWithControls: FlickVideoWithControls(
          controls: WebVideoControl(
            iconSize: 30,
            fontSize: 14,
            progressBarSettings: FlickProgressBarSettings(
              height: 5,
              handleRadius: 5.5,
            ),
          ),
          videoFit: BoxFit.contain,
          // aspectRatioWhenLoading: 4 / 3,
        ),
      ),
    );
  }
}
