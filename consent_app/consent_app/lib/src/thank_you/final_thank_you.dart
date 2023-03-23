import 'dart:convert';

import 'package:consent_app/src/procedure_chooser_feature/procedure_item_list_view.i18n.dart';
import 'package:consent_app/src/summary_feature/summary_view.dart';
import 'package:flutter/material.dart';

import '../../database.dart';
import '../../main.dart';
import '../components/frame.dart';

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';

class FinalThankYou extends StatefulWidget {
  const FinalThankYou({Key? key}) : super(key: key);
  static const routeName = '/Finalthankyou';

  @override
  State<FinalThankYou> createState() => _FinalThankYouState();
}

class _FinalThankYouState extends State<FinalThankYou> {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();
    Store store = locator<Store>();
    var choicesJson = jsonEncode(store.choices);

    insertFeedback(choicesJson, store.surveyResults);
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
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
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

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FrameView(
        heading: 'FINAL Thank You'.i18n,
        body: Center(
            child: Column(children: [
          Text('Final Thank you for your participation!'.i18n),
          const SizedBox(height: 40),
          locator<Store>().debugMode
              ? Text('Connection Status: ${_connectionStatus.toString()}')
              : Container(),
          const SizedBox(height: 10),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.restorablePushNamed(
                    context,
                    SummaryView.routeName,
                  );
                },
                child: Text('Ok Done'.i18n),
              ),
            ],
          )
        ])));
  }
}
