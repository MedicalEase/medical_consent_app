import 'package:consent_app/src/video_player_feature/video_item_dataclass.dart';

class ProcedureData {
  static const List<VideoItem> data = [
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

  ProcedureData();
}
