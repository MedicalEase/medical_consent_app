/// A dataclass for a video clip
class VideoItem {
const  VideoItem(
      {required this.id,
      required this.path,
      required this.heading,
      required this.summary,
      required this.questionAfter,
      required this.subtitles});

  final int id;
  final String path;
  final String heading;
  final String summary;
  final int questionAfter;
  final List<SubtitleLine> subtitles;

  String getSubtitle({position: Duration}) {
    for (final subtitle in subtitles) {
      if (position >= subtitle.start && position <= subtitle.end) {
        return subtitle.text;
      }
    }
    return '';
  }
}

class SubtitleLine {
  const SubtitleLine(this.text, this.start, this.end);

  final String text;
  final Duration start;
  final Duration end;
}
