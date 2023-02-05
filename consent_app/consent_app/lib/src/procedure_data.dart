import 'package:consent_app/src/video_player_feature/video_item_dataclass.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class ProcedureData {
  static const List<VideoItem> data = [
    VideoItem(
      0,
      'assets/video/1-2-intro.mp4',
      'Risks and benefits',
      'This video shows your options and discusses some unlikely '
          'side-effects',
      [
        SubtitleLine(1, 'Hello', Duration(seconds: 0), Duration(seconds: 5)),
        SubtitleLine(2, 'World', Duration(seconds: 5), Duration(seconds: 10)),
      ],
    ),
    VideoItem(1, 'assets/video/2-3-ogd_explanation.mp4', 'What is and OGD?',
        'An OGD means we will take some photos for further investigation.', [
      SubtitleLine(1, 'Hello', Duration(seconds: 0), Duration(seconds: 5)),
      SubtitleLine(2, 'World', Duration(seconds: 5), Duration(seconds: 10)),
    ]),
    VideoItem(
      2,
      'assets/video/3-4-ogd_question.mp4',
      'Are you happy to proceed?',
      'PLease press Yes, No or Not Sure.',
      [
        SubtitleLine(1, 'Hello', Duration(seconds: 0), Duration(seconds: 5)),
        SubtitleLine(2, 'World', Duration(seconds: 5), Duration(seconds: 10)),
      ],
    ),
    VideoItem(
      3,
      'assets/video/4-5-sedation_question.mp4',
      'Video Heading',
      'This video shows your options and discusses some unlikely '
          'side-effects',
      [
        SubtitleLine(1, 'Hello', Duration(seconds: 0), Duration(seconds: 5)),
        SubtitleLine(2, 'World', Duration(seconds: 5), Duration(seconds: 10)),
      ],
    ),
  ];

  ProcedureData();
}

class Translations {
  String en = 'not set';
  String gr = 'not set';
  String tr = 'not set';

  Translations({required this.en, required this.gr, required this.tr});
}

class TranslationData {
  static Map<String, Translations> data = {
    'OGD': Translations(
      en: 'OGD',
      gr: 'greek OGD',
      tr: 'tr OGD',
    ),
    'Procedure': Translations(
      en: 'Procedure',
      gr: 'Πρόγραμμα',
      tr: 'Prosedür',
    ),
    'Risks and benefits': Translations(
      en: 'Settings',
      gr: 'Ρυθμίσεις',
      tr: 'Ayarlar',
    ),
  };
}


// Settings
// Choose Language
// Summary
// Questions
// No
// OK
// waiting for video to load
// Next
// Choose Procedure
// Procedure
