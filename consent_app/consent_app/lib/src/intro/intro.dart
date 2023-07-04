import 'dart:async';
import 'package:consent_app/src/procedure_chooser_feature/procedure_item_list_view.dart';
import 'package:flutter/material.dart';

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
    return Container(
          decoration: const BoxDecoration(color: Color(0xff325FF9)),
          child: Center(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Column(
                  children: [
                    Image.asset('assets/images/medical-abstract.png',
                      width: 200, height: 200,),
                  ],
                ),
              )),
        );
  }

  void onClose() {
    Navigator.pushReplacementNamed(
      context,
      ProcedureListView.routeName);
  }

}

