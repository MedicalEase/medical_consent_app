import 'package:consent_app/src/procedure_chooser_feature/procedure_item_list_view.i18n.dart';
import 'package:consent_app/src/survey/survey.dart';
import 'package:consent_app/src/thank_you/final_thank_you.dart';
import 'package:flutter/material.dart';

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
          const SizedBox(height: 40),
          Text('Would you like to fill out a survey?'.i18n),
          const SizedBox(height: 10),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  store.choices.add('survey participation');
                  Navigator.restorablePushNamed(
                    context,
                    SurveyView.routeName,
                  );
                },
                child: Text('Ok Survey'.i18n),
              ),
              ElevatedButton(
                onPressed: () {
                  store.choices.add('No survey');
                  Navigator.restorablePushNamed(
                    context,
                    FinalThankYou.routeName,
                  );
                },
                child: Text('No Survey'.i18n),
              )
            ],
          )
        ])));
  }
}
