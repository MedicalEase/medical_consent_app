import 'package:consent_app/src/video_player_feature/video_item_dataclass.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SubtitleContent extends StatelessWidget {
  const SubtitleContent({Key? key, required this.controller, required this.item}) :
super(key:
  key);
  final VideoItem item;
  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Text(
      item.getSubtitle(position: controller.value.position),
      style: const TextStyle(
        color: Colors.white,
        backgroundColor: Colors.black,
        fontSize: 20,
      ),
    );
  }
}
