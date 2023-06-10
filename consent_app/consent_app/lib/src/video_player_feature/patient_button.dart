import 'package:consent_app/main.i18n.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

import 'dart:developer' as developer;

class PatientButton extends StatefulWidget {
  final String text;
  final Function function;
  final Color? backColor;
  final Color? textColor;
  final IconData icon;

  PatientButton({
    Key? key,
    required this.text,
    required this.function,
    this.backColor = const Color(0xFF005EB8),
    this.icon =  Icons.fast_forward,
    this.textColor =  Colors.white,
  }) : super(key: key);

  @override
  PatientButtonState createState() => PatientButtonState();
}

class PatientButtonState extends State<PatientButton> {
  get icon => this.widget.icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left:48.0,right:48, top :14, bottom: 10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.backColor,
          foregroundColor: widget.textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7.0),
          ),
        ),
        onPressed: () {
          Store store = locator<Store>();
          developer.log('clicked ${widget.text}') ;
          store.choices.add({
            'procedure': store.procedure.name,
            'procedure_id': store.procedure.id,
            'video_id': store.videoItem.id,
            'event': widget.text,
            'heading': store.videoItem.heading,
            'timestamp': DateTime.now().toIso8601String(),
          });
          widget.function(context);
        },
        child: Row(
          children: [
             Icon(
              this.icon,
              color: this.widget.textColor,
              opticalSize: 60,
            ),
            Text( '${widget.text}'.i18n, style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
