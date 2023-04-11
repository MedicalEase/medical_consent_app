import 'package:consent_app/src/intro/intro.dart';
import 'package:consent_app/src/procedure_chooser_feature/procedure_item_list_view.i18n.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../components/frame.dart';

class SummaryView extends StatelessWidget {
  const SummaryView({super.key});

  static const routeName = '/summary';

  @override
  Widget build(BuildContext context) {
    Store store = locator<Store>();
    return FrameView(
        heading: 'Summary',
        body: Center(
            child: Container(
              padding: const EdgeInsets.all(20),

              child: Column(

                  children: [
          Text('Based on the information you provided, we recommend the following:'),

          const SizedBox(height: 10),
                    const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 160,
                    ),
                    Text('Proceed'),
                    const Icon(
                      Icons.flag_circle,
                      color: Colors.orange,
                      size: 160,
                    ),
                    Text('Flagged'),
                    const Icon(
                      Icons.cancel,
                      color: Colors.red,
                      size: 160,
                    ),
                    Text('Consent not obtained'),
          const SizedBox(height: 10),
          ElevatedButton(
              onPressed: () {
                Navigator.restorablePushNamed(
                  context,
                  MyHomePage.routeName,
                );
              },
              child: Text('Restart'.i18n),
          )
        ]),
            )));
  }
}

