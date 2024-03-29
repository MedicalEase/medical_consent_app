import 'package:consent_app/src/language_chooser_feature/language_item_list_view.dart';
import 'package:flutter/material.dart';
import '../components/frame.dart';
import '../components/horizontal_chooser.dart';
import '../../main.dart';

onTapChooseProcedure(item, store, context) {
  store.procedure = item;
  Navigator.pushReplacementNamed(
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
      heading: 'Choose the procedure the patient is having',
      showSettings: true,
      body: horizontalChooser(items, store, context, onTapChooseProcedure),
    );
  }
}

