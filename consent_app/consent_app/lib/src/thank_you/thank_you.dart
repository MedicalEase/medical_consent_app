import 'dart:convert';

import 'package:consent_app/src/procedure_chooser_feature/procedure_item_list_view.i18n.dart';
import 'package:consent_app/src/summary_feature/summary_view.dart';
import 'package:flutter/material.dart';

import '../../database.dart';
import '../../main.dart';
import '../components/frame.dart';
import '../video_player_feature/video_item_details_view.dart';

class ThankYouView extends StatelessWidget {
  const ThankYouView({super.key});

  static const routeName = '/thankyou';

  @override
  Widget build(BuildContext context) {
    Store store = locator<Store>();
    if (store.userProcedures.isEmpty) {
      return do_survey_question(store, context);
    } else {
      store.choices.add('completed viewing of procedure set: ' + store.userProcedures.first.name);
      print('completed viewing of procedure set: ' + store.userProcedures.first.name);
      store.userProcedures.removeAt(0);
      print('now viewing of procedure set: ' + store.userProcedures.first.name);
          return do_next_procedure(store, context);
    }
  }

  Widget do_survey_question(Store store, BuildContext context) {
    return FrameView(
        heading: 'Thank You'.i18n,
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Center(
              child: Column(
                  children: [

            Text('Thank you for your participation!'.i18n),
            Text('Please return the iPad to your healthcare professional'.i18n),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    store.choices.add({
                      'procedure':store.procedure.name,
                      'procedure_id':store.procedure.id,
                      'video_id':99,
                      'event': 'Finished consent sequence',
                      'heading':'Done',
                      'timestamp': DateTime.now().toIso8601String(),
                    });
                    var jsonChoicesData = jsonEncode(store.choices);
                    insertFeedback(jsonChoicesData, '', store.language);
                    //reset the choices collected data
                    store.choices = [];
                    Navigator.restorablePushNamed(
                      context,
                      SummaryView.routeName,
                    );
                  },
                  child: Text('Ok Return to Clinician'.i18n),
                ),
              ],
            )
          ])),
        ));
  }

  Widget do_next_procedure(Store store, BuildContext context) {
    return FrameView(
        heading: 'Procedure Information Complete'.i18n,
        body: Center(
            child: Column(children: [
          Text('Thank you for watching these videos!'.i18n),
          const SizedBox(height: 40),
          Text('Now watch the next set:'.i18n ),
          const SizedBox(height: 10),
              Text( store.userProcedures.first.name ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.restorablePushNamed(
                    context,
                    VideoItemDetailsView.routeName,
                    arguments: store.userProcedures.first.id,
                  );
                },
                child: Text('Watch next procedure set'.i18n),
              ),
              ElevatedButton(
                onPressed: () {
                  store.choices.add('Quit Finish');
                  Navigator.restorablePushNamed(
                    context,
                    FinalThankYou.routeName,
                  );
                },
                child: Text('Quit'.i18n),
              )
            ],
          )
        ])));
  }
}
