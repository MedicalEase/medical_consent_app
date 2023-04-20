import 'package:flutter/material.dart';

class SummaryStatement extends StatelessWidget {
  SummaryStatement({super.key, required this.value});

  String value = '';

  @override
  Widget build(BuildContext context) {
    switch (value) {
      case ('yes'):
        value =
            'The patient has successfully consented. \nYou may offer the patient your '
            'Trust consent form to sign.';
        break;
      case ('no'):
        value =
            'The patient does not want to proceed. You should not consent the patient';
        break;
      default: {
        value =
        'The patient requires some further information. You SHOULD NOT CONSENT YET.';
      }
      }

    return Container(
      child: Container(
        padding:
            const EdgeInsets.only(top: 40, bottom: 20, left: 40, right: 40),
        child: Flexible(child: Text(softWrap: true, maxLines: 3, value)),
      ),
    );
  }
}
