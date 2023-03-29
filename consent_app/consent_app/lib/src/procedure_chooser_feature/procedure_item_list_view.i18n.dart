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
  } + {
    "en": "Next",
    "tr": "Next TURKISH",
    "gr": "Next GREEK",
  } + {
    "en": "Yes",
    "tr": "yep  39: tr",
    "gr": "yep 40 GR",
  } + {
    "en": "No",
    "tr": "NO 43 tr",
    "gr": "NO 44 GR",
  } +

      {
    'en' : 'Was it made clear to you WHAT procedure you were having?',
    'tr' : 'Was it made clear to you WHAT procedure you were having? tr',
    'gr' : 'Was it made clear to you WHAT procedure you were having? gr',
  }

  ;

  String get i18n => localize(this, _t);
}
