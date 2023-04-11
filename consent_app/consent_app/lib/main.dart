import 'dart:math';

import 'package:consent_app/src/procedure_chooser_feature/procedure_item_dataclass.dart';
import 'package:consent_app/src/thank_you/thank_you.dart';
import 'package:consent_app/src/video_player_feature/patient_button.dart';
import 'package:consent_app/src/video_player_feature/video_item_dataclass.dart';
import 'package:consent_app/src/video_player_feature/video_item_details_view.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';

import 'database.dart';
import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';
import 'dart:developer' as developer;

GetIt locator = GetIt.instance;

String randomizer() {
  // give device a random id on initial run
  return '${Random().nextInt(100000)}';
}

class Store {
  late Procedure procedure;
  Future<Database> database = initDb();
  String language = "en";
  late VideoItem videoItem;
  bool debugMode = false;
  String deviceId = 'anonymous_device_${randomizer()}';
  String surveyResults = "";
  List<Map<dynamic, dynamic>> choices = [];
  List procedures = [
    Procedure(id: 0, name: 'OGD', icon: 'assets/images/ogd_icon.png', videos: [
      VideoItem(
          id: 0,
          path: 'assets/video/1-2-intro.mp4',
          heading: '0 Risks and benefits',
          questionAfter: 2,
          nextVideoItemId: 1,
          faqVideoItemId: 3,
          questionBank: [
            PatientButton(
                text: 'Yes',
                backColor: Colors.green,
                function: (BuildContext context) {
                  developer.log('yes');
                  Navigator.restorablePushNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: 1,
                  );
                }),
            PatientButton(
                text: 'No',
                backColor: Colors.red,
                function: (BuildContext context) {
                  print('no');
                  Navigator.restorablePushNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: 2,
                  );
                }),
            PatientButton(
                text: 'Not Sure',
                function: (BuildContext context) {
                  print('maybe');
                  Navigator.restorablePushNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: 2,
                  );
                }),
          ],
          subtitles: [
            const SubtitleLine(
                'Hello en', Duration(seconds: 0), Duration(seconds: 5), 'en'),
            const SubtitleLine(
                'World2 tk', Duration(seconds: 1), Duration(seconds: 4), 'tr'),
            const SubtitleLine(
                'World2 gr', Duration(seconds: 1), Duration(seconds: 4), 'gr'),
            const SubtitleLine(
                'World2 en', Duration(seconds: 4), Duration(seconds: 7), 'en'),
          ]),
      VideoItem(
          id: 1,
          path: 'assets/video/2-3-ogd_explanation.mp4',
          heading: '2: What is and OGD?',
          questionAfter: 3,
          nextVideoItemId: 2,
          faqVideoItemId: 3,
          questionBank: [
            PatientButton(
                text: 'ok!',
                function: (BuildContext context) {
                  print('ok');
                  Navigator.restorablePushNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: 0,
                  );
                })
          ],
          subtitles: [
            const SubtitleLine(
                'Hello', Duration(seconds: 0), Duration(seconds: 5), 'en'),
            const SubtitleLine(
                'World', Duration(seconds: 5), Duration(seconds: 10), 'en'),
          ]),
      VideoItem(
          id: 2,
          path: 'assets/video/3-4-ogd_question.mp4',
          heading: '3 Are you happy to proceed?',
          questionAfter: 3,
          questionBank: [
            PatientButton(
                text: 'finish!',
                function: (BuildContext context) {
                  print('ok');
                  Navigator.restorablePushNamed(
                    context,
                    ThankYouView.routeName,
                  );
                })
          ],
          subtitles: [
            const SubtitleLine(
                'Hello', Duration(seconds: 0), Duration(seconds: 5), 'en'),
            const SubtitleLine(
                'Hello2', Duration(seconds: 1), Duration(seconds: 4), 'en'),
            const SubtitleLine(
                'World', Duration(seconds: 5), Duration(seconds: 10), 'en'),
          ]),
      VideoItem(
        id: 3,
        path: 'assets/video/4-5-sedation_question.mp4',
        heading: ' 4 Sedation question',
        nextVideoItemId: 0,
        questionAfter: 3,
        subtitles: [
          const SubtitleLine(
              'Hello', Duration(seconds: 0), Duration(seconds: 5), 'en'),
          const SubtitleLine(
              'World', Duration(seconds: 5), Duration(seconds: 10), 'en'),
        ],
      )
    ]),
    Procedure(
        id: 1,
        name: 'Flexible Sigmoidoscopy',
        icon: 'assets/images/sigmoidoscopy_icon.png',
        videos: [
          VideoItem(
              id: 0,
              path: 'assets/video/2-3-ogd_explanation.mp4',
              heading: 'What is  Flexible Sigmoidoscopy?',
              questionAfter: 3,
              questionBank: [],
              subtitles: [
                const SubtitleLine(
                    'Hello', Duration(seconds: 0), Duration(seconds: 5), 'en'),
                const SubtitleLine(
                    'World', Duration(seconds: 0), Duration(seconds: 5), 'tk'),
              ])
        ]),
    Procedure(
        id: 2,
        name: 'Colonoscopy',
        icon: 'assets/images/colonscopy_icon.png',
        videos: [
          VideoItem(
              id: 0,
              path: 'assets/video/2-3-ogd_explanation.mp4',
              heading: 'What is  Flexible Sigmoidoscopy?',
              questionBank: [],
              questionAfter: 3,
              subtitles: [
                const SubtitleLine(
                    'Hello', Duration(seconds: 0), Duration(seconds: 5), 'en'),
                const SubtitleLine(
                    'World', Duration(seconds: 0), Duration(seconds: 5), 'tk'),
              ])
        ]),
    Procedure(
        id: 3,
        name: 'OGD \n+ Flexible Sigmoidoscopy',
        icon: 'assets/images/ogd_icon.png',
        videos: [
          VideoItem(
              id: 0,
              path: 'assets/video/2-3-ogd_explanation.mp4',
              heading: 'What is  Flexible Sigmoidoscopy?',
              questionBank: [],
              questionAfter: 3,
              subtitles: [
                const SubtitleLine(
                    'Hello', Duration(seconds: 0), Duration(seconds: 5), 'en'),
                const SubtitleLine(
                    'World', Duration(seconds: 0), Duration(seconds: 5), 'tk'),
              ])
        ]),
    Procedure(
        id: 4,
        name: 'OGD + colonoscopy',
        icon: 'assets/images/ogd_icon.png',
        videos: [
          VideoItem(
              id: 0,
              path: 'assets/video/2-3-ogd_explanation.mp4',
              heading: 'What is  Flexible Sigmoidoscopy?',
              questionBank: [],
              questionAfter: 3,
              subtitles: [
                const SubtitleLine(
                    'Hello', Duration(seconds: 0), Duration(seconds: 5), 'en'),
                const SubtitleLine(
                    'World', Duration(seconds: 0), Duration(seconds: 5), 'tk'),
              ])
        ]),
    const Procedure(
        id: 5,
        name: 'Survey',
        icon: 'assets/images/survey_icon.png',
        videos: []),
  ];
// todo SettingsController settingsController = SettingsController();
}

RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

Future<void> setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  locator.registerSingleton<Store>(Store());
  locator.allowReassignment = true;
}

void main() async {
  setup();
  ensureSetting('deviceId', locator<Store>().deviceId);
  print('insertSetting done');
  final settingsController = SettingsController(SettingsService());
  await settingsController.loadSettings();
  runApp(MyApp(settingsController: settingsController));
}
