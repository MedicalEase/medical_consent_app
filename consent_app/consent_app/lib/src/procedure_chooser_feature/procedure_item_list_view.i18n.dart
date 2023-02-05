import 'procedure_item_list_view.dart';

import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  static final _t = Translations("en") +
  {
  "en": "Choose Procedure",
  "tr" : "",
  "gr": "¿Hola! Cómo estás?",
  };

  String get i18n => localize(this, _t);
}
// Choose Procedure in greek: