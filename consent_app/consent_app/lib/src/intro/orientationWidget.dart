import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
class OrientationWarning extends StatelessWidget {

  const OrientationWarning({super.key,n});

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    return orientation == Orientation.portrait
        ? Row(
      children: const [
        Icon(Icons.rotate_90_degrees_cw,
            size: 60,
            color: Colors.red),
        Text(' Please rotate your device to landscape mode',
            style: TextStyle(
              fontSize: 30,
              color: Colors.red,
            )
        ),
      ],
    )
        : Container();
  }
}
