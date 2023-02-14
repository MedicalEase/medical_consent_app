import 'procedure_item_list_view.dart';

import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  static final _t = Translations("en") +
      {
        "en": "Procedure",
        "tr": "procedure  tr",
        "gr": "PROCERD GR",
      } +
      {
        "en": "Choose Procedure",
        "tr": "procedure choice tr",
        "gr": "¿Hola! Cómo estás?",
      } +
      {
        "en": "Choose Language",
        "tr": "Choose Language TURKISS",
        "gr": "Choose Language GREEK",
      } +
      {
        "en": "Summary",
        "tr": "Summary TURKISH",
        "gr": "Summary GREEK",
      } +
      {
        "en": "Risks and benefits",
        "tr": "Risks and benefits TURKISH",
        "gr": "Risks and benefits GREEK",
      } + {
        "en": "OGD",
        "tr": "OGD (but in TURKISH)",
        "gr": "OGD (but in GREEK)",

  }
      ;

  String get i18n => localize(this, _t);
}
// Choose Procedure in greek:
