import 'package:consent_app/src/procedure_chooser_feature/procedure_item_dataclass.dart';
import 'package:consent_app/src/video_player_feature/video_item_dataclass.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'database.dart';
import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

GetIt locator = GetIt.instance;

class Store {
  late Procedure procedure;
  Future<Database> database = initDb();
  String language = "en";
  List choices = [];
  List procedures = [
    const Procedure(
        id: 0,
        name: 'OGD',
        icon: 'assets/images/ogd_icon.png',
        videos: [
          VideoItem(
              id: 0,
              path: 'assets/video/1-2-intro.mp4',
              heading: 'Risks and benefits',
              summary:
                  'This video shows your options and discusses some unlikely side-effects',
              questionAfter: 1,
              nextVideoItemId: 1,
              faqVideoItemId: 3,
              subtitles: [
                SubtitleLine('Hello en', Duration(seconds: 0),
                    Duration(seconds: 5), 'en'),
                SubtitleLine('World2 tk', Duration(seconds: 1),
                    Duration(seconds: 4), 'tr'),
                SubtitleLine('World2 gr', Duration(seconds: 1),
                    Duration(seconds: 4), 'gr'),
                SubtitleLine('World2 en', Duration(seconds: 4),
                    Duration(seconds: 7), 'en'),
              ]),
          VideoItem(
              id: 1,
              path: 'assets/video/2-3-ogd_explanation.mp4',
              heading: '2: What is and OGD?',
              summary: '2 An OGD means we will take some photos for further '
                  'investigation.',
              questionAfter: 3,
              nextVideoItemId: 2,
              faqVideoItemId: 3,
              subtitles: [
                SubtitleLine(
                    'Hello', Duration(seconds: 0), Duration(seconds: 5), 'en'),
                SubtitleLine(
                    'World', Duration(seconds: 5), Duration(seconds: 10), 'en'),
              ]),
          VideoItem(
              id: 2,
              path: 'assets/video/3-4-ogd_question.mp4',
              heading: '3 Are you happy to proceed?',
              summary: 'PLease press Yes, No or Not Sure.',
              questionAfter: 3,
              subtitles: [
                SubtitleLine(
                    'Hello', Duration(seconds: 0), Duration(seconds: 5), 'en'),
                SubtitleLine(
                    'Hello2', Duration(seconds: 1), Duration(seconds: 4), 'en'),
                SubtitleLine(
                    'World', Duration(seconds: 5), Duration(seconds: 10), 'en'),
              ]),
          VideoItem(
            id: 3,
            path: 'assets/video/4-5-sedation_question.mp4',
            heading: ' 4 Sedation question',
            summary: 'This video has details about sedation',
            nextVideoItemId: 0,
            questionAfter: 3,
            subtitles: [
              SubtitleLine(
                  'Hello', Duration(seconds: 0), Duration(seconds: 5), 'en'),
              SubtitleLine(
                  'World', Duration(seconds: 5), Duration(seconds: 10), 'en'),
            ],
          )
        ]),
    const Procedure(
        id: 1,
        name: 'Flexible Sigmoidoscopy',
        icon: 'assets/images/sigmoidoscopy_icon.png',
        videos: [
          VideoItem(
              id: 0,
              path: 'assets/video/2-3-ogd_explanation.mp4',
              heading: 'What is  Flexible Sigmoidoscopy?',
              summary:
                  'An Flexible Sigmoidoscopy means we will take some photos for further investigation.',
              questionAfter: 3,
              subtitles: [
                SubtitleLine(
                    'Hello', Duration(seconds: 0), Duration(seconds: 5), 'en'),
                SubtitleLine(
                    'World', Duration(seconds: 0), Duration(seconds: 5), 'tk'),
              ])
        ]),
    const Procedure(
        id: 2,
        name: 'Colonoscopy',
        icon: 'assets/images/colonscopy_icon.png',
        videos: [
          VideoItem(
              id: 0,
              path: 'assets/video/2-3-ogd_explanation.mp4',
              heading: 'What is  Flexible Sigmoidoscopy?',
              summary:
                  'An Flexible Sigmoidoscopy means we will take some photos for further investigation.',
              questionAfter: 3,
              subtitles: [
                SubtitleLine(
                    'Hello', Duration(seconds: 0), Duration(seconds: 5), 'en'),
                SubtitleLine(
                    'World', Duration(seconds: 0), Duration(seconds: 5), 'tk'),
              ])
        ]),
  ];
// todo SettingsController settingsController = SettingsController();
}

Future<void> setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  locator.registerSingleton<Store>(Store());
  locator.allowReassignment = true;
}

void main() async {
  setup();
  ensureSetting('deviceId', 'anonymous');
  print('insertSetting done');
  final settingsController = SettingsController(SettingsService());
  await settingsController.loadSettings();
  runApp(MyApp(settingsController: settingsController));
}
