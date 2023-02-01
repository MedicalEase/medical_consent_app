import '../video_player_feature/video_item_dataclass.dart';

/// A dataclass for a procedure (e.g. a surgery)

class Procedure {
  const Procedure(this.id, this.name, this.videos);

  final int id;
  final String name;
  final List<VideoItem> videos;
}

class ProcedureNames {
  static const List<Procedure> data = [
    Procedure(0, 'OGD', []),
    Procedure(1, 'Flexible Sigmoidoscopy', []),
    Procedure(2, 'Colonoscopy', []),
  ];

  ProcedureNames();
}