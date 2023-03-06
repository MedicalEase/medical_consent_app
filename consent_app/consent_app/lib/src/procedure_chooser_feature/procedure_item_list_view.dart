import 'package:consent_app/src/language_chooser_feature/language_item_list_view.dart';
import 'package:flutter/material.dart';
import '../components/frame.dart';
import '../components/horizontal_chooser.dart';
import '../../main.dart';

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

