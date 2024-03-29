import 'package:consent_app/src/video_player_feature/video_item_dataclass.dart';
import 'package:consent_app/src/video_player_feature/video_subtitle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:video_player/video_player.dart';


class ExplainerAssetVideo extends StatefulWidget {
  final String path;
  final VideoItem item;
  final VideoPlayerController? controller;
  Duration position = const Duration(seconds: 0);

  ExplainerAssetVideo({Key? key,
    required this.path,
    required this.item,
    required this.controller})
      : super(key: key);

  @override
  ExplainerAssetVideoState createState() => ExplainerAssetVideoState();
}

class ExplainerAssetVideoState extends State<ExplainerAssetVideo> {
  VideoPlayerController? _controller = null;

  @override
  void initState() {
    print('asset video init started');
    super.initState();
    _controller = widget.controller;
    _controller!.addListener(() {
      setState(() {
        widget.position = _controller!.value.position;
      });
    });
    _controller!.setLooping(false);
    _controller!.initialize().then((_) => setState(() {}));
    _controller!.play();
    print('asset video init done');
  }


  @override
  void deactivate() {
    print('47 deactivate');
    super.deactivate();
  }

  @override
  void dispose() {
    print('53 asset video dispose');
    if (_controller != null) {
      _controller!.pause();
      _controller!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              child: AspectRatio(
                aspectRatio: _controller!.value.aspectRatio,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    VideoPlayer(_controller!),
                    _ControlsOverlay(
                        controller: _controller, item: widget.item),
                    VideoProgressIndicator(
                      _controller!,
                      allowScrubbing: true,
                      //todo remove scrubbing
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
          ),
            SizedBox(
            height: 82,
            child: Center(
              child: Column(
                children: [
                  should_show_instructions()
                      ? Animate(
                    effects: const [
                      FadeEffect(),
                    ],
                    child:  Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: widget.item.questionBank,
                        ))
                        : const Text(
                    ' ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 60,
                    ),
                  ),
                ],
              ),
            ),
          )
        ]);
  }

  bool should_show_instructions() {
    if (widget.item.questionAfter! > 0) {
      // do calc from start of video
      return (widget.position.inSeconds.toInt() >=
          (widget.item.questionAfter ?? 0));
    } else {
      // do calc from end of video: nb: questionAfter is negative! so we add!
      int showPoint = widget.controller!.value.duration.inSeconds +
          widget.item.questionAfter!;
      return (widget.position.inSeconds.toInt() >= (showPoint ?? 0));
    }
  }
}

class _ControlsOverlay extends StatelessWidget {
  _ControlsOverlay({Key? key, required this.controller, required this.item})
      : super(key: key);

  VideoPlayerController? controller = null;
  final VideoItem item;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          reverseDuration: const Duration(milliseconds: 200),
          child: (controller!.value.position > const Duration(seconds: 1) &&
              controller!.value.position == controller!.value.duration)
              ? overlayIcon(Icons.replay, 'Replay')
              : controller!.value.isPlaying
              ? const SizedBox.shrink()
              : overlayIcon(Icons.play_arrow, 'Play'),
        ),
        GestureDetector(
          onTap: () {
            if (controller!.value.position == controller!.value.duration) {
              controller!.seekTo(const Duration(seconds: 0));
              controller!.play();
            }
            controller!.value.isPlaying ? controller!.pause() : controller!
                .play();
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
                controller: controller!,
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
