import 'dart:math';

import 'package:consent_app/src/procedure_chooser_feature/procedure_item_dataclass.dart';
import 'package:consent_app/src/summary_feature/summary_data.dart';
import 'package:consent_app/src/summary_feature/summary_view.dart';
import 'package:consent_app/src/video_player_feature/patient_button.dart';
import 'package:consent_app/src/video_player_feature/video_item_dataclass.dart';
import 'package:consent_app/src/video_player_feature/video_item_details_view.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:sqflite/sqflite.dart';

import 'database.dart';
import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

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
  SummaryData summary = SummaryData();
  List<Map<dynamic, dynamic>> choices = [];
  Map<String, String> consentMessages = {};
  List procedures = [
    Procedure(id: 0, name: 'OGD', icon: 'assets/images/ogd_icon.png', videos: [
      VideoItem(
          id: 0,
          path: 'OGD1_INTRO.mov',
          heading: '0: OGD1_INTRO.mov',
          questionAfter: -5,
          subtitles: [],
          questionBank: [
            PatientButton(
                text: 'Replay',
                icon: Icons.fast_rewind,
                backColor: Colors.black,
                textColor: Colors.white,
                function: (BuildContext context) {
                  Navigator.pushReplacementNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: 0,
                  );
                }),
            PatientButton(
                text: 'Yes',
                icon: Icons.done,
                backColor: Colors.green,
                textColor: Colors.white,
                function: (BuildContext context) {
                  Navigator.pushReplacementNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: 2,
                  );
                }),
            PatientButton(
                text: 'No',
                icon: Icons.close,
                backColor: Colors.red,
                textColor: Colors.white,
                function: (BuildContext context) {
                  Navigator.pushReplacementNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: 1,
                  );
                })
          ]),
      VideoItem(
          id: 1,
          path: 'FAQ1_GENERAL.mov',
          heading: '1:FAQ1_GENERAL.mov',
          questionAfter: -5,
          subtitles: [],
          questionBank: [
            PatientButton(
                text: 'Replay',
                icon: Icons.fast_rewind,
                backColor: Colors.black,
                textColor: Colors.white,
                function: (BuildContext context) {
                  Navigator.pushReplacementNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: 1,
                  );
                }),
            PatientButton(
                text: 'Yes',
                icon: Icons.done,
                backColor: Colors.green,
                textColor: Colors.white,
                function: (BuildContext context) {
                  Navigator.pushReplacementNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: 2,
                  );
                }),
            PatientButton(
                text: 'No',
                icon: Icons.close,
                backColor: Colors.red,
                textColor: Colors.white,
                function: (BuildContext context) {
                  locator<Store>().summary.willProceed = 'not yet';
                  Navigator.pushReplacementNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: 2,
                  );
                })
          ]),
      VideoItem(
          id: 2,
          path: 'OGD2_THROAT_SPRAY.mov',
          heading: '2:changed: OGD2_THROAT_SPRAY.mov',
          questionAfter: -6,
          subtitles: [],
          questionBank: [
            PatientButton(
                text: 'Replay',
                icon: Icons.fast_rewind,
                backColor: Colors.black,
                textColor: Colors.white,
                function: (BuildContext context) {
                  Navigator.pushReplacementNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: 2,
                  );
                }),
            PatientButton(
                text: 'Yes',
                icon: Icons.done,
                backColor: Colors.green,
                textColor: Colors.white,
                function: (BuildContext context) {
                  Navigator.pushReplacementNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: 4,
                  );
                }),
            PatientButton(
                text: 'No',
                icon: Icons.close,
                backColor: Colors.red,
                textColor: Colors.white,
                function: (BuildContext context) {
                  locator<Store>().summary.throatSpray = 'no';
                  Navigator.pushReplacementNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: 4,
                  );
                }),
            PatientButton(
                text: 'More',
                icon: Icons.help_outline,
                backColor: Colors.grey,
                textColor: Colors.white,
                function: (BuildContext context) {
                  locator<Store>().summary.throatSpray = 'not yet';
                  Navigator.pushReplacementNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: 3,
                  );
                })
          ]),
      VideoItem(
          id: 3,
          path: 'FAQ2_THROAT_SPRAY.mov',
          heading: '3: FAQ2_THROAT_SPRAY.mov',
          questionAfter: -6,
          subtitles: [],
          questionBank: [
            PatientButton(
                text: 'Replay',
                icon: Icons.fast_rewind,
                backColor: Colors.black,
                textColor: Colors.white,
                function: (BuildContext context) {
                  Navigator.pushReplacementNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: 3,
                  );
                }),
            PatientButton(
                text: 'Yes',
                icon: Icons.done,
                backColor: Colors.green,
                textColor: Colors.white,
                function: (BuildContext context) {
                  Navigator.pushReplacementNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: 4,
                  );
                }),
            PatientButton(
                text: 'No',
                icon: Icons.close,
                backColor: Colors.red,
                textColor: Colors.white,
                function: (BuildContext context) {
                  locator<Store>().summary.throatSpray = 'no';
                  Navigator.pushReplacementNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: 4,
                  );
                }),
            PatientButton(
                text: 'More',
                icon: Icons.help_outline,
                backColor: Colors.grey,
                textColor: Colors.white,
                function: (BuildContext context) {
                  locator<Store>().summary.throatSpray = 'not yet';
                  locator<Store>().summary.willProceed = 'not yet';
                  Navigator.pushReplacementNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: 4,
                  );
                })
          ]),
      VideoItem(
          id: 4,
          path: 'OGD3_SEDATION.mov',
          heading: '4: OGD3_SEDATION.mov',
          questionAfter: -7,
          subtitles: [],
          questionBank: [
            PatientButton(
                text: 'Replay',
                icon: Icons.fast_rewind,
                backColor: Colors.black,
                textColor: Colors.white,
                function: (BuildContext context) {
                  Navigator.pushReplacementNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: 4,
                  );
                }),
            PatientButton(
                text: 'Yes',
                icon: Icons.done,
                backColor: Colors.green,
                textColor: Colors.white,
                function: (BuildContext context) {
                  Navigator.pushReplacementNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: 7,
                  );
                }),
            PatientButton(
                text: 'No',
                icon: Icons.close,
                backColor: Colors.red,
                textColor: Colors.white,
                function: (BuildContext context) {
                  locator<Store>().summary.sedation = 'no';
                  Navigator.pushReplacementNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: 16,
                  );
                }),
            PatientButton(
                text: 'Start',
                icon: Icons.flaky,
                backColor: Colors.white,
                textColor: Colors.grey,
                function: (BuildContext context) {
                  locator<Store>().summary.sedation = 'not yet';
                  Navigator.pushReplacementNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: 6,
                  );
                }),
            PatientButton(
                text: 'without',
                icon: Icons.help_outline,
                backColor: Colors.grey,
                textColor: Colors.white,
                function: (BuildContext context) {
                  locator<Store>().summary.sedation = 'no';
                  Navigator.pushReplacementNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: 5,
                  );
                })
          ]),
      VideoItem(
          id: 5,
          path: 'FAQ3_SEDATION.mov',
          heading: '5:FAQ3_SEDATION.mov',
          questionAfter: -7,
          subtitles: [],
          questionBank: [
            PatientButton(
                text: 'Replay',
                icon: Icons.fast_rewind,
                backColor: Colors.black,
                textColor: Colors.white,
                function: (BuildContext context) {
                  Navigator.pushReplacementNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: 5,
                  );
                }),
            PatientButton(
                text: 'Yes',
                icon: Icons.done,
                backColor: Colors.green,
                textColor: Colors.white,
                function: (BuildContext context) {
                  Navigator.pushReplacementNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: 7,
                  );
                }),
            PatientButton(
                text: 'No',
                icon: Icons.close,
                backColor: Colors.red,
                textColor: Colors.white,
                function: (BuildContext context) {
                  locator<Store>().summary.sedation = 'no';
                  Navigator.pushReplacementNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: 16,
                  );
                }),
            PatientButton(
                text: 'Start',
                icon: Icons.flaky,
                backColor: Colors.white,
                textColor: Colors.grey,
                function: (BuildContext context) {
                  locator<Store>().summary.sedation = 'not yet';
                  Navigator.pushReplacementNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: 6,
                  );
                }),
            PatientButton(
                text: 'without',
                icon: Icons.help_outline,
                backColor: Colors.grey,
                textColor: Colors.white,
                function: (BuildContext context) {
                  locator<Store>().summary.sedation = 'no';
                  locator<Store>().summary.willProceed = 'not yet';
                  Navigator.pushReplacementNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: 16,
                  );
                })
          ]),
      VideoItem(
          id: 6,
          path: '_placeholder.mov',
          heading: '6: AUDIO_AND_VIDEO_EXAMPLES.mov',
          questionAfter: -5,
          subtitles: [],
          questionBank: [
            PatientButton(
                text: 'Replay',
                icon: Icons.fast_rewind,
                backColor: Colors.black,
                textColor: Colors.white,
                function: (BuildContext context) {
                  Navigator.pushReplacementNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: 6,
                  );
                }),
            PatientButton(
                text: 'Yes',
                icon: Icons.done,
                backColor: Colors.green,
                textColor: Colors.white,
                function: (BuildContext context) {
                  Navigator.pushReplacementNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: 7,
                  );
                }),
            PatientButton(
                text: 'No',
                icon: Icons.close,
                backColor: Colors.red,
                textColor: Colors.white,
                function: (BuildContext context) {
                  locator<Store>().summary.sedation = 'no';
                  Navigator.pushReplacementNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: 16,
                  );
                })
          ]),
      VideoItem(
          id: 7,
          path: 'ALL1_COLLECTION.mov',
          heading: '7: ALL1_COLLECTION.mov',
          questionAfter: -6,
          subtitles: [],
          questionBank: [
            PatientButton(
                text: 'Replay',
                icon: Icons.fast_rewind,
                backColor: Colors.black,
                textColor: Colors.white,
                function: (BuildContext context) {
                  Navigator.pushReplacementNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: 7,
                  );
                }),
            PatientButton(
                text: 'Yes',
                icon: Icons.done,
                backColor: Colors.green,
                textColor: Colors.white,
                function: (BuildContext context) {
                  Navigator.pushReplacementNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: 11,
                  );
                }),
            PatientButton(
                text: 'No',
                icon: Icons.close,
                backColor: Colors.red,
                textColor: Colors.white,
                function: (BuildContext context) {
                  locator<Store>().summary.beingCollected = 'no';
                  Navigator.pushReplacementNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: 10,
                  );
                }),
            PatientButton(
                text: 'More',
                icon: Icons.help_outline,
                backColor: Colors.grey,
                textColor: Colors.white,
                function: (BuildContext context) {
                  locator<Store>().summary.beingCollected = 'not yet';
                  Navigator.pushReplacementNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: 9,
                  );
                })
          ]),
      VideoItem(
          id: 8,
          path: 'ALL1.1_COLLECTION_REPLAY.mov',
          heading: '8: ALL1.1_COLLECTION_REPLAY.mov',
          questionAfter: -6,
          subtitles: [],
          questionBank: [
            PatientButton(
                text: 'Replay',
                icon: Icons.fast_rewind,
                backColor: Colors.black,
                textColor: Colors.white,
                function: (BuildContext context) {
                  Navigator.pushReplacementNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: 8,
                  );
                }),
            PatientButton(
                text: 'Yes',
                icon: Icons.done,
                backColor: Colors.green,
                textColor: Colors.white,
                function: (BuildContext context) {
                  Navigator.pushReplacementNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: 11,
                  );
                }),
            PatientButton(
                text: 'No',
                icon: Icons.close,
                backColor: Colors.red,
                textColor: Colors.white,
                function: (BuildContext context) {
                  locator<Store>().summary.beingCollected = 'no';
                  Navigator.pushReplacementNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: 10,
                  );
                }),
            PatientButton(
                text: 'More',
                icon: Icons.help_outline,
                backColor: Colors.grey,
                textColor: Colors.white,
                function: (BuildContext context) {
                  locator<Store>().summary.beingCollected = 'not yet';
                  Navigator.pushReplacementNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: 9,
                  );
                })
          ]),
      VideoItem(
          id: 9,
          path: 'FAQ4_COLLECTION.mov',
          heading: '9: FAQ4_COLLECTION.mov',
          questionAfter: -6,
          subtitles: [],
          questionBank: [
            PatientButton(
                text: 'Replay',
                icon: Icons.fast_rewind,
                backColor: Colors.black,
                textColor: Colors.white,
                function: (BuildContext context) {
                  Navigator.pushReplacementNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: 9,
                  );
                }),
            PatientButton(
                text: 'Yes',
                icon: Icons.done,
                backColor: Colors.green,
                textColor: Colors.white,
                function: (BuildContext context) {
                  Navigator.pushReplacementNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: 11,
                  );
                }),
            PatientButton(
                text: 'No',
                icon: Icons.close,
                backColor: Colors.red,
                textColor: Colors.white,
                function: (BuildContext context) {
                  locator<Store>().summary.beingCollected = 'no';
                  Navigator.pushReplacementNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: 15,
                  );
                }),
            PatientButton(
                text: 'More',
                icon: Icons.help_outline,
                backColor: Colors.grey,
                textColor: Colors.white,
                function: (BuildContext context) {
                  locator<Store>().summary.willProceed = 'not yet';
                  locator<Store>().summary.beingCollected = 'not yet';
                  Navigator.pushReplacementNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: 16,
                  );
                })
          ]),
      VideoItem(
          id: 10,
          path: 'FAQ4.1_COLLECTION_.mov',
          heading: '10: FAQ4.1_COLLECTION_.mov',
          questionAfter: -6,
          subtitles: [],
          questionBank: [
            PatientButton(
                text: 'Replay',
                icon: Icons.fast_rewind,
                backColor: Colors.black,
                textColor: Colors.white,
                function: (BuildContext context) {
                  Navigator.pushReplacementNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: 10,
                  );
                }),
            PatientButton(
                text: 'Yes',
                icon: Icons.done,
                backColor: Colors.green,
                textColor: Colors.white,
                function: (BuildContext context) {
                  Navigator.pushReplacementNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: 11,
                  );
                }),
            PatientButton(
                text: 'No',
                icon: Icons.close,
                backColor: Colors.red,
                textColor: Colors.white,
                function: (BuildContext context) {
                  locator<Store>().summary.beingCollected = 'no';
                  Navigator.pushReplacementNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: 15,
                  );
                }),
            PatientButton(
                text: 'More',
                icon: Icons.help_outline,
                backColor: Colors.grey,
                textColor: Colors.white,
                function: (BuildContext context) {
                  locator<Store>().summary.willProceed = 'not yet';
                  locator<Store>().summary.beingCollected = 'not yet';
                  Navigator.pushReplacementNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: 16,
                  );
                })
          ]),
      VideoItem(
          id: 11,
          path: 'ALL2_24HOURS.mov',
          heading: '11: changed: ALL2_24_HOURS.mov',
          questionAfter: -6,
          subtitles: [],
          questionBank: [
            PatientButton(
                text: 'Replay',
                icon: Icons.fast_rewind,
                backColor: Colors.black,
                textColor: Colors.white,
                function: (BuildContext context) {
                  Navigator.pushReplacementNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: 11,
                  );
                }),
            PatientButton(
                text: 'Yes',
                icon: Icons.done,
                backColor: Colors.green,
                textColor: Colors.white,
                function: (BuildContext context) {
                  Navigator.pushReplacementNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: 16,
                  );
                }),
            PatientButton(
                text: 'No',
                icon: Icons.close,
                backColor: Colors.red,
                textColor: Colors.white,
                function: (BuildContext context) {
                  locator<Store>().summary.beingAccompanied = 'no';
                  Navigator.pushReplacementNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: 14,
                  );
                }),
            PatientButton(
                text: 'More',
                icon: Icons.help_outline,
                backColor: Colors.grey,
                textColor: Colors.white,
                function: (BuildContext context) {
                  locator<Store>().summary.beingAccompanied = 'not yet';
                  Navigator.pushReplacementNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: 13,
                  );
                })
          ]),
      VideoItem(
          id: 12,
          path: 'ALL2.1_24_HOURS_REPLAY.mov',
          heading: '12: ALL2.1_24_HOURS_REPLAY.mov',
          questionAfter: -6,
          subtitles: [],
          questionBank: [
            PatientButton(
                text: 'Replay',
                icon: Icons.fast_rewind,
                backColor: Colors.black,
                textColor: Colors.white,
                function: (BuildContext context) {
                  Navigator.pushReplacementNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: 12,
                  );
                }),
            PatientButton(
                text: 'Yes',
                icon: Icons.done,
                backColor: Colors.green,
                textColor: Colors.white,
                function: (BuildContext context) {
                  Navigator.pushReplacementNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: 16,
                  );
                }),
            PatientButton(
                text: 'No',
                icon: Icons.close,
                backColor: Colors.red,
                textColor: Colors.white,
                function: (BuildContext context) {
                  locator<Store>().summary.beingAccompanied = 'no';
                  Navigator.pushReplacementNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: 14,
                  );
                }),
            PatientButton(
                text: 'More',
                icon: Icons.help_outline,
                backColor: Colors.grey,
                textColor: Colors.white,
                function: (BuildContext context) {
                  locator<Store>().summary.beingAccompanied = 'not yet';
                  Navigator.pushReplacementNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: 13,
                  );
                })
          ]),
      VideoItem(
          id: 13,
          path: 'FAQ5_24_HOURS.mov',
          heading: '13: FAQ5_24_HOURS.mov',
          questionAfter: -6,
          subtitles: [],
          questionBank: [
            PatientButton(
                text: 'Replay',
                icon: Icons.fast_rewind,
                backColor: Colors.black,
                textColor: Colors.white,
                function: (BuildContext context) {
                  Navigator.pushReplacementNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: 13,
                  );
                }),
            PatientButton(
                text: 'Yes',
                icon: Icons.done,
                backColor: Colors.green,
                textColor: Colors.white,
                function: (BuildContext context) {
                  Navigator.pushReplacementNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: 16,
                  );
                }),
            PatientButton(
                text: 'No',
                icon: Icons.close,
                backColor: Colors.red,
                textColor: Colors.white,
                function: (BuildContext context) {
                  locator<Store>().summary.beingAccompanied = 'no';
                  Navigator.pushReplacementNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: 15,
                  );
                }),
            PatientButton(
                text: 'More',
                icon: Icons.help_outline,
                backColor: Colors.grey,
                textColor: Colors.white,
                function: (BuildContext context) {
                  locator<Store>().summary.willProceed = 'not yet';
                  locator<Store>().summary.beingAccompanied = 'not yet';
                  Navigator.pushReplacementNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: 16,
                  );
                })
          ]),
      VideoItem(
          id: 14,
          path: 'FAQ5.1_24_HOURS.mov',
          heading: '14: FAQ5.1_24_HOURS.mov',
          questionAfter: -6,
          subtitles: [],
          questionBank: [
            PatientButton(
                text: 'Replay',
                icon: Icons.fast_rewind,
                backColor: Colors.black,
                textColor: Colors.white,
                function: (BuildContext context) {
                  Navigator.pushReplacementNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: 14,
                  );
                }),
            PatientButton(
                text: 'Yes',
                icon: Icons.done,
                backColor: Colors.green,
                textColor: Colors.white,
                function: (BuildContext context) {
                  Navigator.pushReplacementNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: 16,
                  );
                }),
            PatientButton(
                text: 'No',
                icon: Icons.close,
                backColor: Colors.red,
                textColor: Colors.white,
                function: (BuildContext context) {
                  locator<Store>().summary.beingAccompanied = 'no';
                  Navigator.pushReplacementNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: 15,
                  );
                }),
            PatientButton(
                text: 'More',
                icon: Icons.help_outline,
                backColor: Colors.grey,
                textColor: Colors.white,
                function: (BuildContext context) {
                  locator<Store>().summary.willProceed = 'not yet';
                  locator<Store>().summary.beingAccompanied = 'not yet';
                  Navigator.pushReplacementNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: 16,
                  );
                })
          ]),
      VideoItem(
          id: 15,
          path: '_placeholder.mov',
          heading: '15: _placeholder',
          questionAfter: -5,
          subtitles: [],
          questionBank: [
            PatientButton(
                text: 'Replay',
                icon: Icons.fast_rewind,
                backColor: Colors.black,
                textColor: Colors.white,
                function: (BuildContext context) {
                  Navigator.pushReplacementNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: 15,
                  );
                }),
            PatientButton(
                text: 'Yes',
                icon: Icons.done,
                backColor: Colors.green,
                textColor: Colors.white,
                function: (BuildContext context) {
                  locator<Store>().summary.willProceed = 'not yet';
                  Navigator.pushReplacementNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: 16,
                  );
                }),
            PatientButton(
                text: 'No',
                icon: Icons.close,
                backColor: Colors.red,
                textColor: Colors.white,
                function: (BuildContext context) {
                  Navigator.pushReplacementNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: 16,
                  );
                })
          ]),
      VideoItem(
          id: 16,
          path: 'OGD4_RISKS.mov',
          heading: '16: OGD4_RISKS.mov',
          questionAfter: -5,
          subtitles: [],
          questionBank: [
            PatientButton(
                text: 'Replay',
                icon: Icons.fast_rewind,
                backColor: Colors.black,
                textColor: Colors.white,
                function: (BuildContext context) {
                  Navigator.pushReplacementNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: 16,
                  );
                }),
            PatientButton(
                text: 'Yes',
                icon: Icons.done,
                backColor: Colors.green,
                textColor: Colors.white,
                function: (BuildContext context) {
                  Navigator.pushReplacementNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: 18,
                  );
                }),
            PatientButton(
                text: 'No',
                icon: Icons.close,
                backColor: Colors.red,
                textColor: Colors.white,
                function: (BuildContext context) {
                  locator<Store>().summary.knowsRisks = 'no';
                  Navigator.pushReplacementNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: 17,
                  );
                })
          ]),
      VideoItem(
          id: 17,
          path: 'FAQ6_OGD_RISKS.mov',
          heading: '17: FAQ6_OGD_RISKS.mov',
          questionAfter: -5,
          subtitles: [],
          questionBank: [
            PatientButton(
                text: 'Replay',
                icon: Icons.fast_rewind,
                backColor: Colors.black,
                textColor: Colors.white,
                function: (BuildContext context) {
                  Store store = locator<Store>();
                  String languageCode = store.language;
                  I18n.of(context).locale = Locale(languageCode);
                  Navigator.pushReplacementNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: 17,
                  );
                }),
            PatientButton(
                text: 'Yes',
                icon: Icons.done,
                backColor: Colors.green,
                textColor: Colors.white,
                function: (BuildContext context) {
                  Navigator.pushReplacementNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: 18,
                  );
                }),
            PatientButton(
                text: 'No',
                icon: Icons.close,
                backColor: Colors.red,
                textColor: Colors.white,
                function: (BuildContext context) {
                  locator<Store>().summary.knowsRisks = 'no';
                  locator<Store>().summary.willProceed = 'not yet';
                  Navigator.pushReplacementNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: 18,
                  );
                })
          ]),
      VideoItem(
          id: 18,
          path: 'ALL3_PROCEED.mov',
          heading: '18: ALL3_PROCEED.mov',
          questionAfter: -6,
          subtitles: [],
          questionBank: [
            PatientButton(
                text: 'Replay',
                icon: Icons.fast_rewind,
                backColor: Colors.black,
                textColor: Colors.white,
                function: (BuildContext context) {
                  Navigator.pushReplacementNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: 18,
                  );
                }),
            PatientButton(
                text: 'Yes',
                icon: Icons.done,
                backColor: Colors.green,
                textColor: Colors.white,
                function: (BuildContext context) {
                  Navigator.pushReplacementNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: 19,
                  );
                }),
            PatientButton(
                text: 'No',
                icon: Icons.close,
                backColor: Colors.red,
                textColor: Colors.white,
                function: (BuildContext context) {
                  Navigator.pushReplacementNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: 19,
                  );
                }),
            PatientButton(
                text: 'More',
                icon: Icons.help_outline,
                backColor: Colors.grey,
                textColor: Colors.white,
                function: (BuildContext context) {
                  Navigator.pushReplacementNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: 19,
                  );
                })
          ]),
      VideoItem(
          id: 19,
          path: 'ALL4A_FINISHED_CONSENT.mov',
          heading: '19: ALL4A_FINISHED_CONSENT.mov',
          questionAfter: 3,
          subtitles: [],
          questionBank: [
            PatientButton(
                text: 'Continue',
                icon: Icons.fast_forward,
                backColor: Colors.grey,
                textColor: Colors.white,
                function: (BuildContext context) {
                  Navigator.pushReplacementNamed(
                    context,
                    SummaryView.routeName,
                  );
                })
          ]),
      VideoItem(
          id: 20,
          path: 'ALL4B_NOT_CONSENTING.mov',
          heading: '20: ALL4B_NOT_CONSENTING.mov',
          questionAfter: 30,
          subtitles: [],
          questionBank: [
            PatientButton(
                text: 'Continue',
                icon: Icons.fast_forward,
                backColor: Colors.grey,
                textColor: Colors.white,
                function: (BuildContext context) {
                  Navigator.pushReplacementNamed(
                    context,
                    SummaryView.routeName,
                  );
                })
          ]),
      VideoItem(
          id: 21,
          path: 'ALL4C_INFO_NEEDED.mov',
          heading: '21: ALL4C_INFO_NEEDED',
          questionAfter: 30,
          subtitles: [],
          questionBank: [
            PatientButton(
                text: 'Continue',
                icon: Icons.fast_forward,
                backColor: Colors.grey,
                textColor: Colors.white,
                function: (BuildContext context) {
                  Navigator.pushReplacementNamed(
                    context,
                    SummaryView.routeName,
                  );
                })
          ]),
    ]),
    // Procedure(
    //     id: 1,
    //     name: 'Flexi-Sigmoidoscopy',
    //     icon: 'assets/images/sigmoidoscopy_icon.png',
    //     videos: [
    //       VideoItem(
    //           id: 0,
    //           path: 'OGD1_INTRO.mov',
    //           heading: '1What is  Flexible Sigmoidoscopy?',
    //           questionAfter: 1,
    //           questionBank: [
    //             PatientButton(
    //                 text: 'Replay',
    //                 icon: Icons.fast_rewind,
    //                 backColor: Colors.black,
    //                 textColor: Colors.white,
    //                 function: (BuildContext context) {
    //                   locator<Store>().summary.throatSpray = 'no';
    //                   Navigator.pushReplacementNamed(
    //                     context,
    //                     VideoItemDetailsView.routeName,
    //                     arguments: 0,
    //                   );
    //                 }),
    //             PatientButton(
    //                 text: 'Yes',
    //                 icon: Icons.done,
    //                 backColor: Colors.green,
    //                 textColor: Colors.white,
    //                 function: (BuildContext context) {
    //                   Navigator.pushReplacementNamed(
    //                     context,
    //                     VideoItemDetailsView.routeName,
    //                     arguments: 2,
    //                   );
    //                 }),
    //             PatientButton(
    //                 text: 'No',
    //                 icon: Icons.close,
    //                 backColor: Colors.red,
    //                 textColor: Colors.white,
    //                 function: (BuildContext context) {
    //                   Navigator.pushReplacementNamed(
    //                     context,
    //                     VideoItemDetailsView.routeName,
    //                     arguments: 1,
    //                   );
    //                 })
    //           ],
    //           subtitles: [
    //             const SubtitleLine(
    //                 'Hello', Duration(seconds: 0), Duration(seconds: 1), 'en'),
    //             const SubtitleLine(
    //                 'World', Duration(seconds: 1), Duration(seconds: 2), 'en'),
    //           ])
    //     ]),
    // Procedure(
    //     id: 2,
    //     name: 'Colonoscopy',
    //     icon: 'assets/images/colonscopy_icon.png',
    //     videos: [
    //       VideoItem(
    //           id: 0,
    //           path: 'OGD1_INTRO.mov',
    //           heading: '2What is  Flexible Sigmoidoscopy?',
    //           questionBank: [
    //             PatientButton(
    //                 text: 'Replay',
    //                 icon: Icons.fast_rewind,
    //                 backColor: Colors.black,
    //                 textColor: Colors.white,
    //                 function: (BuildContext context) {
    //                   locator<Store>().summary.throatSpray = 'no';
    //                   Navigator.pushReplacementNamed(
    //                     context,
    //                     VideoItemDetailsView.routeName,
    //                     arguments: 0,
    //                   );
    //                 }),
    //             PatientButton(
    //                 text: 'Yes',
    //                 icon: Icons.done,
    //                 backColor: Colors.green,
    //                 textColor: Colors.white,
    //                 function: (BuildContext context) {
    //                   Navigator.pushReplacementNamed(
    //                     context,
    //                     VideoItemDetailsView.routeName,
    //                     arguments: 2,
    //                   );
    //                 }),
    //             PatientButton(
    //                 text: 'No',
    //                 icon: Icons.close,
    //                 backColor: Colors.red,
    //                 textColor: Colors.white,
    //                 function: (BuildContext context) {
    //                   Navigator.pushReplacementNamed(
    //                     context,
    //                     VideoItemDetailsView.routeName,
    //                     arguments: 1,
    //                   );
    //                 })
    //           ],
    //           questionAfter: 1,
    //           subtitles: [
    //             const SubtitleLine(
    //                 'Hello', Duration(seconds: 0), Duration(seconds: 1), 'en'),
    //             const SubtitleLine(
    //                 'World', Duration(seconds: 1), Duration(seconds: 5), 'en'),
    //           ])
    //     ]),
    // Procedure(
    //     id: 3,
    //     name: 'OGD \n+ Flexi-Sigmoidoscopy',
    //     icon: 'assets/images/ogd+flexi_icon.png',
    //     videos: [
    //       VideoItem(
    //           id: 0,
    //           path: 'OGD1_INTRO.mov',
    //           heading: '3What is  Flexible Sigmoidoscopy?',
    //           questionBank: [],
    //           questionAfter: 3,
    //           subtitles: [
    //             const SubtitleLine(
    //                 'Hello', Duration(seconds: 0), Duration(seconds: 5), 'en'),
    //             const SubtitleLine(
    //                 'World', Duration(seconds: 0), Duration(seconds: 5), 'tr'),
    //           ])
    //     ]),
    // Procedure(
    //     id: 4,
    //     name: 'OGD + colonoscopy',
    //     icon: 'assets/images/ogd+colon_icon.png',
    //     videos: [
    //       VideoItem(
    //           id: 0,
    //           path: 'OGD1_INTRO.mov',
    //           heading: '4What is  Flexible Sigmoidoscopy?',
    //           questionBank: [],
    //           questionAfter: 3,
    //           subtitles: [
    //             const SubtitleLine(
    //                 'Hello', Duration(seconds: 0), Duration(seconds: 5), 'en'),
    //             const SubtitleLine(
    //                 'World', Duration(seconds: 0), Duration(seconds: 5), 'tr'),
    //           ])
    //     ]),
    // const Procedure(
    //     id: 5,
    //     name: 'Survey',
    //     icon: 'assets/images/survey_icon.png',
    //     videos: []),
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
  Store store = locator<Store>();
  ensureSetting('deviceId', store.deviceId);
  store.deviceId = await getSetting('deviceId');

  ensureSetting(
      'consentSuccessMessage',
      store.consentMessages['consentSuccessMessage'] ??
          'The patient has successfully consented, you MAY OFFER '
              'the patient your Trust consent form to sign');
  store.consentMessages['consentSuccessMessage'] =
      await getSetting('consentSuccessMessage');
  ensureSetting(
      'consentFailMessage',
      store.consentMessages['consentFailMessage'] ??
          'The patient does not want to proceed, you SHOULD NOT CONSENT the patient.'
              '  Please call BigWord on XXXXXXXXXXXX, using access code XXX '
              'and select Greek/Turkish by typing XXX/XXX when prompted to'
              ' understand their decision.');
  store.consentMessages['consentInfoMessage'] =
      await getSetting('consentInfoMessage');
  ensureSetting(
      'consentInfoMessage',
      store.consentMessages['consentInfoMessage'] ??
          'The patient requires some further '
              'information, you SHOULD NOT CONSENT YET.'
              'Please call BigWord on XXXXXXXXXXXX, using access code XXX '
              'and select Greek/Turkish by typing XXX/XXX when prompted to '
              'help provide the additional information required.');
  store.consentMessages['consentFailMessage'] =
      await getSetting('consentFailMessage');
  print('insertSetting done');
  final settingsController = SettingsController(SettingsService());
  await settingsController.loadSettings();
  runApp(MyApp(settingsController: settingsController));
}
