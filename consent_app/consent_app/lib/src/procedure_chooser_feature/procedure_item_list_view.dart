import 'package:consent_app/src/language_chooser_feature/language_item_list_view.dart';
import 'package:consent_app/src/video_player_feature/video_item_list_view.dart';
import 'package:flutter/material.dart';
import 'package:i18n_extension/i18n_extension.dart';
import '../components/frame.dart';
import '../components/horizontal_chooser.dart';
import 'procedure_item_list_view.i18n.dart';
import '../../main.dart';
import '../procedure_data.dart';
import '../settings/settings_view.dart';
import 'procedure_item_dataclass.dart';

onTap(item, store, context) {
  print('clik');
  store.procedure = item;
  Navigator.restorablePushNamed(
      context,
      LanguageListView.routeName,
      arguments: item.id,
  );
}

class ProcedureListView extends StatelessWidget {
  const ProcedureListView({
    super.key,
  });

  static const routeName = '/procedures';

  @override
  Widget build(BuildContext context) {
    Store store = locator<Store>();
    var items = store.procedures;
    return FrameView(
      heading: 'Choose Procedure',
      body: horizontalChooser(items, store, context, onTap),
    );
  }
}

