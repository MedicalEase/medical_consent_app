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
    this.questionBank = const [],

  });

  final int id;
  final String path;
  final String heading;
  final List<SubtitleLine> subtitles;
   int? questionAfter = 1;
  final List<PatientButton> questionBank;

  String getFullPath() {
    Store store = locator<Store>();
    String lang = store.language;
    var fullPath = 'assets/video/$lang/$path';
    print('full path: $fullPath ');
    return fullPath;
  }

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
