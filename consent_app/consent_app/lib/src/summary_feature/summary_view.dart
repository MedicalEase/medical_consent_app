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
          Text('Result: ${store.choices}'),
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
    var tableRows = [
      for (var item in store.choices)
        DataRow(
          cells: <DataCell>[
            DataCell(Text(item)),
          ],
        ),
    ];

    return Column(
      children: [
        Text('Procedure Choices'),
        DataTable(
          columns: const <DataColumn>[
            DataColumn(
              label: Expanded(
                child: Text(
                  'Video Section',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'Selection',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
          ],
          rows: tableRows,
        ),
      ],
    );
  }
}
