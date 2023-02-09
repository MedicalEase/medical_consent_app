import 'package:consent_app/src/video_player_feature/video_item_dataclass.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class ProcedureData {
  static const List<VideoItem> data = [
    const VideoItem(
      id: 0,
      path: 'assets/video/1-2-intro.mp4',
      heading: 'Risks and benefits',
      summary:
          'This video shows your options and discusses some unlikely side-effects',
      questionAfter: 2,
       subtitles: [
        SubtitleLine('Hello', Duration(seconds: 0), Duration(seconds: 5)),
        SubtitleLine('World', Duration(seconds: 5), Duration(seconds: 10)),
      ],
    ),
    const VideoItem(
        id: 1,
        path: 'assets/video/2-3-ogd_explanation.mp4',
        heading: 'What is and OGD?',
        summary:
            'An OGD means we will take some photos for further investigation.',
        questionAfter: 3,
        subtitles: [
          SubtitleLine('Hello', Duration(seconds: 0), Duration(seconds: 5)),
          SubtitleLine('World', Duration(seconds: 5), Duration(seconds: 10)),
        ]),
    const VideoItem(
      id: 2,
      path: 'assets/video/3-4-ogd_question.mp4',
      heading: 'Are you happy to proceed?',
      summary: 'PLease press Yes, No or Not Sure.',
      questionAfter: 5,
      subtitles: [
        SubtitleLine('Hello', Duration(seconds: 0), Duration(seconds: 5)),
        SubtitleLine('World', Duration(seconds: 5), Duration(seconds: 10)),
      ],
    ),
    const VideoItem(
      id: 3,
      path: 'assets/video/4-5-sedation_question.mp4',
      heading: 'Video Heading',
      summary:
          'This video shows your options and discusses some unlikely side-effects',
      questionAfter: 3,
      subtitles: [
        SubtitleLine('Hello', Duration(seconds: 0), Duration(seconds: 5)),
        SubtitleLine('World', Duration(seconds: 5), Duration(seconds: 10)),
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
      en: 'Summary',
      gr: 'Σύνοψη',
      tr: 'Özet',
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
