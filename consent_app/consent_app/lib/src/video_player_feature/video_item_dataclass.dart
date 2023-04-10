import 'package:consent_app/src/video_player_feature/patient_button.dart';

import '../../main.dart';

/// A dataclass for a video clip
class VideoItem {
   VideoItem({
    required this.id,
    required this.path,
    required this.heading,
     this.questionAfter = 1,
    required this.subtitles,
    this.nextVideoItemId,
    this.faqVideoItemId,
    this.questionBank = const [],

  });

  final int id;
  final String path;
  final String heading;
  final List<SubtitleLine> subtitles;
   int? questionAfter = 1;
  final int? nextVideoItemId;
  final int? faqVideoItemId;
  final List<PatientButton> questionBank;

  String getSubtitle({Duration position = Duration.zero}) {
    Store store = locator<Store>();
    for (final subtitle in subtitles) {
      if ((subtitle.language == store.language) &&
          (position >= subtitle.start && position <= subtitle.end)) {
        return subtitle.text;
      }
    }
    return '';
  }
}

class SubtitleLine {
  const SubtitleLine(this.text, this.start, this.end, this.language);

  final String text;
  final Duration start;
  final Duration end;
  final String language;
}
