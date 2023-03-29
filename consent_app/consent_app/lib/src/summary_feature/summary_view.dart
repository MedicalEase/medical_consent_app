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
            child: Column(children: [
          Text('Language: ${store.language}'),
          const SizedBox(height: 10),
          ChoicesTable(),
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
        ])));
  }
}

class ChoicesTable extends StatelessWidget {
  const ChoicesTable({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Store store = locator<Store>();

    return Column(children: [Text('Procedure Choices')]);
  }
}
