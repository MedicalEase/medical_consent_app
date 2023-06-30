import 'package:flutter/material.dart';

import '../../main.dart';

class FrameView extends StatefulWidget {
  const FrameView({
    super.key,
    required this.heading,
    required this.body,
    this.showSettings = false,
  });

  final String heading;
  final Widget body;
  final bool showSettings;

  @override
  State<FrameView> createState() => _FrameViewState();
}

class _FrameViewState extends State<FrameView> {
  bool debug = false;


  @override
  Widget build(BuildContext context) {
    print('this.widget.showSettings');
    print(this.widget.showSettings);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: locator<Store>().debugMode,
        title: Text(widget.heading),
      ),
      body: widget.body,
    );
  }
}
