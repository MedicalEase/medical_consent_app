import 'dart:convert';

import 'package:consent_app/src/procedure_chooser_feature/procedure_item_list_view.i18n.dart';
import 'package:consent_app/src/summary_feature/summary_view.dart';
import 'package:flutter/material.dart';

import '../../database.dart';
import '../../main.dart';
import '../components/frame.dart';

class ThankYouView extends StatelessWidget {
  const ThankYouView({super.key});

  static const routeName = '/thankyou';

  @override
  Widget build(BuildContext context) {
    Store store = locator<Store>();
    return FrameView(
        heading: 'Thank You'.i18n,
        body: Center(
            child: Column(children: [
          Text('Thank you for your participation!'.i18n),
          Text('Please return the iPad to your healthcare professional'.i18n),
          const SizedBox(height: 40),
          Row(
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
        ])));
  }
}
