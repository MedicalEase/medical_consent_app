// import 'package:i18n_extension/i18n_extension.dart';
//
// extension Localization on String {
//
//   static final _t = Translations.byLocale("en") +
//       {
//         "en": {
//           "Yes": "Hi2.",
//           "Goodbye.": "Goodbye.",
//         },
//         "gr": {
//           "Yes": "Hola.",
//           "Goodbye.": "Adiós.",
//         }
//       };
//
//   String get i18n => localize(this, _t);
// }
import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {

  static final _t = Translations("en") +
      {
        "en": "Yes",
        "gr": "Ναί",
      } +
      {
        "en": "No",
        "gr": "Όχι",
      } +
      {
        "en": "Replay",
        "gr": "Επανάληψη",
    } +
      {
        "en": "Next",
        "gr": "Επόμενο",
    } +
      {
        "en": "More",
        "gr": "περισσότερο"} +
      {
        "en": "Start",
        "gr": "Αρχή",
      } +
  {
    "en": "Continue",
    "gr": "συνεχίζεται",
  };


  String get i18n => localize(this, _t);
}
