import 'package:consent_app/src/intro/intro.dart';
import 'package:consent_app/src/summary_feature/summary_icon.dart';
import 'package:consent_app/src/summary_feature/summary_statement.dart';
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
          child: Column(children: [
            // Text('Based on the information you provided, we recommend the following:'),
            DataTable(columns: <DataColumn>[
              DataColumn(
                label: Expanded(
                  child: Text(
                    ' ',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    ' ',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ),
            ], rows: <DataRow>[
              DataRow(
                cells: <DataCell>[
                  DataCell(Text('Does the patient want a throat spray?')),
                  DataCell(SummaryIcon(
                    value: store.summary.throatSpray,
                  )),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text('Does the patient want sedation?')),
                  DataCell(SummaryIcon(
                    value: store.summary.sedation,
                  )),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(
                      Text('Does the patient have someone collecting them?')),
                  DataCell(SummaryIcon(value: store.summary.beingCollected)),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text(
                      'Does the patient have someone with them for 24hrs?')),
                  DataCell(SummaryIcon(
                    value: store.summary.beingAccompianied,
                  )),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text('Does the patient understand the risks?')),
                  DataCell(SummaryIcon(
                    value: store.summary.knowsRisks,
                  )),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text('Does the patient want to proceed?')),
                  DataCell(SummaryIcon(
                    value: store.summary.willProceed,
                  )),
                ],
              ),
            ]),

            SummaryStatement( value: store.summary.willProceed,),
            ElevatedButton(
              onPressed: () {
                Navigator.restorablePushNamed(
                  context,
                  MyHomePage.routeName,
                );
              },
              child: Text('Restart'),
            )
          ]),
        )));
  }
}
