import 'package:flutter/material.dart';

import '../../main.dart';


class PatientButton extends StatefulWidget {
  final String text;
  final Function function;
  final Color? backColor;
  final Color? textColor;

  PatientButton({
    Key? key,
    required this.text,
    required this.function,
    this.backColor = const Color(0xFF005EB8),
    this.textColor =  Colors.white,
  }) : super(key: key);

  @override
  PatientButtonState createState() => PatientButtonState();
}

class PatientButtonState extends State<PatientButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.backColor,
          foregroundColor: widget.textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        onPressed: () {
          Store store = locator<Store>();
          store.choices.add({
            'procedure': store.procedure.name,
            'procedure_id': store.procedure.id,
            'video_id': store.videoItem.id,
            'event': widget.text,
            'heading': store.videoItem.heading,
            'timestamp': DateTime.now().toIso8601String(),
          });
          widget.function();
        },
        child: Text(widget.text),
      ),
    );
  }
}
