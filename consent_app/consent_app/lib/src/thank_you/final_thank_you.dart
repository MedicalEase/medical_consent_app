import 'package:consent_app/src/intro/intro.dart';
import 'package:consent_app/src/procedure_chooser_feature/procedure_item_list_view.dart';
import 'package:consent_app/src/procedure_chooser_feature/procedure_item_list_view.i18n.dart';
import 'package:consent_app/src/summary_feature/summary_view.dart';
import 'package:consent_app/src/survey/survey.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../components/frame.dart';
import '../settings/settings_view.dart';
import '../video_player_feature/video_item_list_view.dart';

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:consent_app/src/components/frame.dart';
import 'package:consent_app/src/procedure_chooser_feature/procedure_item_list_view.dart';
import 'package:consent_app/src/procedure_chooser_feature/procedure_item_list_view.i18n.dart';
import 'package:consent_app/src/summary_feature/summary_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

import '../../main.dart';
import '../settings/settings_view.dart';
import '../video_player_feature/video_item_dataclass.dart';
import '../video_player_feature/video_item_details_view.dart';
import '../video_player_feature/video_item_list_view.dart';

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
        heading: 'FiNAL Thank You'.i18n,
        body: Center(
            child: Column(children: [
          Text('Final Thank you for your participation!'.i18n),
          const SizedBox(height: 40),
          Text('Connection Status: ${_connectionStatus.toString()}'),
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
