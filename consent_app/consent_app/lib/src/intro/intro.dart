import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:consent_app/src/components/frame.dart';
import 'package:consent_app/src/intro/unsyncedCountWidget.dart';
import 'package:consent_app/src/procedure_chooser_feature/procedure_item_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../../database.dart';
import '../../main.dart';
import 'orientationWidget.dart';

Future<void> syncData() async {
  print('sync database');
  Store store = locator<Store>();
  String deviceId = store.deviceId;
  var rows = await getUnsyncedFeedback();
  List datarow = rows
      .map((e) => {
            ...e,
            ...{'deviceId': deviceId}
          })
      .toList();
  String jsonSurveys = jsonEncode(datarow);
  Future<bool> responseSuccess = postSurvey(jsonSurveys);
  var ids = rows.map((ele) => ele['id']).toList();
  if (await responseSuccess) {
    await updateAllSurveyData(ids);
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
    Store store = locator<Store>();
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
                    "Consentease v 0.1",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 64),
                  ),
                ),
              ),
              _connectionStatus == ConnectivityResult.none
                  ? Container()
                  : const UnsyncedCountWidget(),
              Text('Device ID: ${store.deviceId}'),
              store.debugMode
                  ? Text('Debug mode: ${store.debugMode}')
                  : Container(),
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
    if (connectionStatus == ConnectivityResult.none) {
      print('No connection, not syncing surveys');
      return;
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
