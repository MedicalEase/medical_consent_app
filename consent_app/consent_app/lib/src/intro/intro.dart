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
        heading: 'Welcome',
        body: Center(
            child: FittedBox(
          fit: BoxFit.fill,
          child: Column(
            children: [
              FittedBox(
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
              Text('Connection Status: ${_connectionStatus.toString()}',
                  style: TextStyle(fontSize: 32)),
              Image.asset('assets/images/medical-abstract.png'),

              //               ExplainerAssetVideo(
              //   key: Key(item.id.toString()),
              //   path: item.path,
              //   item: item,
              //   controller: videoController,
              // ),
              Padding(
                  padding: EdgeInsets.all(30),
                  child: IntrinsicWidth(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(30),
                            child: ElevatedButton(
                              child: Text(
                                'Continue',
                                style: TextStyle(fontSize: 64),
                              ),
                              onPressed: () {
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
}
