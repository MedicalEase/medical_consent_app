import 'dart:async';
import 'package:consent_app/src/components/frame.dart';
import 'package:consent_app/src/procedure_chooser_feature/procedure_item_list_view.dart';
import 'package:flutter/material.dart';
import '../../main.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  static const routeName = '/home';

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  initState() {
    super.initState();
    Timer(const Duration(seconds: 1), onClose);
  }

  @override
  Widget build(BuildContext context) {
    Store store = locator<Store>();
    return FrameView(
        heading: '',
        showSettings: true,
        body: Container(
          decoration: const BoxDecoration(color: Color(0xff325FF9)),
          child: Center(
              child: FittedBox(
                fit: BoxFit.fill,
                child: Column(
                  children: [
                    const FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Padding(
                        padding: EdgeInsets.all(30),
                        child: Text(
                          "Consentease v 0.1.3",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 64),
                        ),
                      ),
                    ),
                    Text('Device ID: ${store.deviceId}'),
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
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    onPressed: () {
                                      Navigator.pushReplacementNamed(
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
              )),
        ));
  }

  void onClose() {
    Navigator.pushReplacementNamed(
      context,
      ProcedureListView.routeName);
  }

}

