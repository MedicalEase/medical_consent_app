import 'package:consent_app/src/video_player_feature/video_item_details_view.dart';
import 'package:flutter/material.dart';
import 'package:i18n_extension/i18n_widget.dart';

import '../../main.dart';
import '../components/frame.dart';
import '../components/horizontal_chooser.dart';
import 'language_dataclass.dart';

onTapChooseLanguage(language, store, context) {
  store.language = language.code;
  I18n.of(context).locale = Locale(language.code);
  Navigator.pushReplacementNamed(
    context,
    VideoItemDetailsView.routeName,
    arguments: 0,
  );
}

class LanguageListView extends StatelessWidget {
  const LanguageListView({
    super.key,
    this.languages = content,
  });

  static const content = LanguageData.data;
  static const routeName = '/LanguageListView';

  final List<Language> languages;

  @override
  Widget build(BuildContext context) {
    Store store = locator<Store>();
    return FrameView(
        heading: 'Choose the spoken language of the patient',
        showSettings: true,
        body:
          horizontalChooser(languages, store, context, onTapChooseLanguage)
    );
  }
}
