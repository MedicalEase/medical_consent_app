import '../procedure_data.dart';
import '../video_player_feature/video_item_dataclass.dart';

/// A dataclass for a procedure (e.g. a surgery)

class Procedure {
  const Procedure({
    required this.id,
    required this.name,
    required this.videos,
  });

  final int id;
  final String name;
  final List<VideoItem> videos;
}

