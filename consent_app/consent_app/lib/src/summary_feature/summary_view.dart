import 'package:consent_app/src/intro/intro.dart';
import 'package:consent_app/src/summary_feature/summary_icon.dart';
import 'package:consent_app/src/summary_feature/summary_statement.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../components/frame.dart';

class SummaryView extends StatefulWidget {
  const SummaryView({Key? key}) : super(key: key);
  static const routeName = '/summary';

  @override
  State<SummaryView> createState() => _SummaryViewState();
}

class _SummaryViewState extends State<SummaryView> {
  int _counter = 0;
  var _forceRedraw; // generate the key from this

  void _incrementCounter() {
    setState(() {
      _counter++;
      _forceRedraw = Object();
    });
  }

  @override
  void initState() {
    _forceRedraw = Object();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Store store = locator<Store>();
    Future.delayed(Duration(milliseconds: 3000), () {
      _incrementCounter();
    });
    return FrameView(
        heading: 'Summary',
        body: Center(
            child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            // Text('Based on the information you provided, we recommend the following:'),
            DataTable(columns: <DataColumn>[
              DataColumn(
                label: Text(
                  ' ',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              DataColumn(
                label: Text(
                  ' ',
                  style: TextStyle(fontStyle: FontStyle.italic),
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
                    value: store.summary.beingAccompanied,
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

            SummaryStatement(
              value: store.summary.willProceed,
            ),
            StatefullButton(
              key: ValueKey(_forceRedraw),
              counter: _counter,
            ),
          ]),
        )));
  }
}

class StatefullButton extends StatefulWidget {
  final int counter;

  const StatefullButton({
    required this.counter,
    Key? key,
  }) : super(key: key);

  @override
  _StatefullButtonState createState() => _StatefullButtonState();
}

class _StatefullButtonState extends State<StatefullButton> {
  @override
  Widget build(BuildContext context) {
    if (widget.counter > 1) {
      return AnimatedOpacity(
          opacity: 1,
          duration: const Duration(seconds: 3),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushReplacementNamed(
                context,
                MyHomePage.routeName,
              );
            },
            child: Text('Restart'),
          ));
    } else {
      return Container();
    }
  }
}
