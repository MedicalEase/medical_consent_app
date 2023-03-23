import 'package:consent_app/src/language_chooser_feature/language_item_list_view.dart';
import 'package:consent_app/src/procedure_chooser_feature/procedure_item_list_view.i18n.dart';
import 'package:consent_app/src/procedure_chooser_feature/selectable_item.dart';
import 'package:drag_select_grid_view/drag_select_grid_view.dart';
import 'package:flutter/material.dart';
import '../components/frame.dart';
import '../components/horizontal_chooser.dart';
import '../../main.dart';

// onTap(item, store, context) {
//   print('clik');
//   store.procedure = item;
//   Navigator.restorablePushNamed(
//     context,
//     LanguageListView.routeName,
//     arguments: item.id,
//   );
// }

class ProcedureListView extends StatefulWidget {
  const ProcedureListView({
    super.key,
  });

  static const routeName = '/procedures';

  @override
  State<ProcedureListView> createState() => _ProcedureListViewState();
}

class _ProcedureListViewState extends State<ProcedureListView> {
  final controller = DragSelectGridViewController();
  int currentCount = 0;

  @override
  void initState() {
    super.initState();
    controller.addListener(scheduleRebuild);
  }

  @override
  void dispose() {
    controller.removeListener(scheduleRebuild);
    super.dispose();
  }

  void setCount(int newCount) {
        currentCount = newCount;
      }

  void scheduleRebuild() => setState(() {});

  @override
  Widget build(BuildContext context) {
    Store store = locator<Store>();
    var items = store.procedures;
    print(currentCount.toString() + ' currentCount');

    return FrameView(
      heading: 'Choose Procedure',
      body:
          // horizontalChooser(items, store, context, onTap),
          Padding(
        padding: const EdgeInsets.all(48.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: DragSelectGridView(
                triggerSelectionOnTap: true,
                gridController: controller,
                itemCount: items.length,
                itemBuilder: (context, index, selected) {
                  return SelectableItem(
                    index: index,
                    selected: selected,
                    setCount: setCount,
                  );
                },
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 450,
                  crossAxisSpacing: 40,
                  mainAxisSpacing: 40,
                ),
              ),
            ),
            // Text(store.procedure.length.toString() + ' proc len selected currcount: '+ currentCount.toString()),
            (store.userProcedures.length == 0)
                ? Container()
                : ElevatedButton(
                    onPressed: () {

                      Navigator.restorablePushNamed(
                        context,
                        LanguageListView.routeName,
                      );
                    },
                    child: Text(
                      'Continue'.i18n,
                      style: const TextStyle(fontSize: 48),
                    )),
          ],
        ),
      ),
    );
  }
}
