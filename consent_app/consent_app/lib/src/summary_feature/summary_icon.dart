
import 'package:flutter/material.dart';

class SummaryIcon extends StatelessWidget {
  String value;

  SummaryIcon({required this.value}) : super();

  @override
  Widget build(BuildContext context) {
    if (value.toLowerCase() == 'yes') {
      return Row(
        children: [
          Icon(
            Icons.check_circle,
            color: Colors.green,
            opticalSize: 60,
          ),
          Text('Yes',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal)),
        ],
      );
    }
    if (value.toLowerCase() == 'no') {
      return Row(
        children: [
          Icon(
            Icons.cancel,
            color: Colors.red,
            opticalSize: 60,
          ),
          Text('No',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal)),
        ],
      );
    }
    return Row(
      children: [
        Icon(
          Icons.flag_circle,
          color: Colors.orange,
          opticalSize: 60,
        ),
        Text('Help',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal)),
      ],
    );
  }
}