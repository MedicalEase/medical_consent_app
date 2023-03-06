import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:consent_app/src/components/frame.dart';
import 'package:consent_app/src/procedure_chooser_feature/procedure_item_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../../main.dart';

class OrientationSwitcher extends StatelessWidget {
  final List<Widget> children;

  const OrientationSwitcher({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    return orientation == Orientation.portrait
        ? Column(children: children)
        : Row(children: children);
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  static const routeName = '/home';

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    late ConnectivityResult connectivityStatus;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      connectivityStatus = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print('Couldn\'t check connectivity status');
      print(e);
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(connectivityStatus);
  }

  Future<void> _updateConnectionStatus(
      ConnectivityResult connectivityStatus) async {
    setState(() {
      _connectionStatus = connectivityStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FrameView(
        heading: 'Welcome',
        body: Center(
            child: FittedBox(
          fit: BoxFit.fill,
          child: Column(
            children: [
              const FittedBox(
                fit: BoxFit.fitWidth,
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Text(
                    "Ready-Medi-Go",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 64),
                  ),
                ),
              ),
              Text('unsynced',
                  style: const TextStyle(fontSize: 32)),
               UnsyncedCountWidget(),
              Image.asset('assets/images/medical-abstract.png'),
              Padding(
                  padding: const EdgeInsets.all(30),
                  child: IntrinsicWidth(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(30),
                            child: ElevatedButton(
                              child: const Text(
                                'Continue',
                                style: TextStyle(fontSize: 64),
                              ),
                              onPressed: () {
                                syncDataWrapper();
                                Navigator.restorablePushNamed(
                                  context,
                                  ProcedureListView.routeName,
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        )));
  }

  Future<void> syncDataWrapper() async {
    await syncData(_connectionStatus);
  }

  Future<void> syncData(ConnectivityResult connectionStatus) async {
    Store store = locator<Store>();
    var database = store.database;
    if (connectionStatus == ConnectivityResult.none) {
      print('No connection, not syncing surveys');
      return;
    }
    var unsyncedSurveys = await database.allSurveyData
      ..where((row) => row.isSynced);
    List unsyncedSurveysList =
        unsyncedSurveys.where((i) => !i.isSynced).toList();
    unsyncedSurveysList.map((ele) => JsonEncoder(ele));
    String jsonSurveys = jsonEncode(unsyncedSurveysList);
    Future<bool> responseSuccess = postSurvey(jsonSurveys);
    if (await responseSuccess) {
      await database.updateAllSurveyData(unsyncedSurveysList);
    }
  }
}

Future<bool> postSurvey(String jsonString) async {
  try {
    final response = await http.post(
      Uri.parse('http://localhost:8080'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'data': jsonString,
      }),
    );

    print(response.statusCode.toString());
    if (response.statusCode < 300) {
      return true;
    } else {
      print('Failed to sync data.');
      return false;
    }
  } catch (err) {
    print('Caught error: $err');
    return false;
  }
}


class UnsyncedCountWidget extends StatefulWidget {
  const UnsyncedCountWidget({super.key});

  @override
  State<UnsyncedCountWidget> createState() => _UnsyncedCountWidget();
}

class _UnsyncedCountWidget extends State<UnsyncedCountWidget> {

  final Future<String> _calculation = Future<String>.delayed(

    const Duration(seconds: 2),
        () => 'Data Loaded',
  );

  Future<String> unSyncedCount() async {
    Store store = locator<Store>();
    var database = store.database;
    var unsynced = await database.surveyUnsyncedWatch();

    return unsynced.length.toString();
  }


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
              const Icon(
                Icons.check_circle_outline,
                color: Colors.green,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Result: ${snapshot.data}'),
              ),
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
