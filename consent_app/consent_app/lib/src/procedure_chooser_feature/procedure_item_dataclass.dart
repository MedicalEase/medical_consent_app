import '../video_player_feature/video_item_dataclass.dart';

/// A datclass for a procedure (e.g. a surgery)

class Procedure {
  const Procedure(this.id, this.name, this.videos);

  final int id;
  final String name;
  final List<VideoItem> videos ;
}
