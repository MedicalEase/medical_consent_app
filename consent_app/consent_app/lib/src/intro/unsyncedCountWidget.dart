
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'intro.dart';
import 'orientationWidget.dart';

class UnsyncedCountWidget extends StatefulWidget {
  const UnsyncedCountWidget({super.key});

  @override
  State<UnsyncedCountWidget> createState() => _UnsyncedCountWidget();
}

class _UnsyncedCountWidget extends State<UnsyncedCountWidget> {

  int syncCount = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.displayMedium!,
      textAlign: TextAlign.center,
      child: FutureBuilder<String>(
        future: unSyncedCount(), // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            children = <Widget>[
              const OrientationWarning(),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  style: const TextStyle(fontSize: 32),
                  'Currently ${snapshot.data != "0" ? snapshot.data : 'no'} unsynced survey'
                      '${snapshot.data == "1" ? "" : 's'}',
                ),
              ),
              //show the 'sync now' button if there are unsynced surveys
              snapshot.data == "0"
                  ? Container()
                  : Row(
                children: [
                  const Icon(
                    Icons.sync,
                    color: Colors.green,
                    size: 60,
                  ),
                  ElevatedButton(
                    child: const Text(
                      'Sync Now',
                      style: TextStyle(fontSize: 18),
                    ),
                    onPressed: () {
                      syncData();
                      setState(() {});
                    },
                  ),
                ],
              )
            ];
          } else if (snapshot.hasError) {
            children = <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              ),
            ];
          } else {
            children = const <Widget>[
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Awaiting result...'),
              ),
            ];
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            ),
          );
        },
      ),
    );
  }
}
