import '../../main.dart';

/// A dataclass for a video clip
class VideoItem {
  const VideoItem({
    required this.id,
    required this.path,
    required this.heading,
    required this.summary,
     this.questionAfter,
    required this.subtitles,
    this.nextVideoItemId,
    this.faqVideoItemId,
  });

  final int id;
  final String path;
  final String heading;
  final String summary;
  final List<SubtitleLine> subtitles;
  final int? questionAfter;
  final int? nextVideoItemId;
  final int? faqVideoItemId;

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
