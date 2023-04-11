import '../video_player_feature/video_item_dataclass.dart';

/// A dataclass for a procedure (e.g. a surgery)

class Procedure {
  const Procedure({
    required this.id,
    required this.name,
    required this.icon,
    required this.videos,
  });

  @override
  String toString() {
    return 'Procedure{id: $id, name: $name}';
  }

  final int id;
  final String name;
  final String icon;
  final List<VideoItem> videos;
}

