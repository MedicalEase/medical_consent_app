/// A datclass for a video clip
class VideoItem {
  const VideoItem(this.id, this.path, this.subtitles);

  final int id;
  final String path;

  // List<SubtitleLine> subtitles = <SubtitleLine>[];
  final List<SubtitleLine> subtitles ;

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
  const SubtitleLine(this.id, this.text, this.start, this.end);

  final int id;
  final String text;
  final Duration start;
  final Duration end;
}
