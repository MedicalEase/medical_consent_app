import 'package:consent_app/src/procedure_chooser_feature/procedure_item_list_view.i18n.dart';
import 'package:flutter/material.dart';
import '../../main.dart';

Center horizontalChooser(List<dynamic> items, Store store, BuildContext context,
    Function tapFunction) {
  return Center(
      child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 100),
          // Providing a restorationId allows the ListView to restore the
          // scroll position when a user leaves and returns to the app after it
          // has been killed while running in the background.
          restorationId: 'ProcedureListView',
          shrinkWrap: true,
          // itemCount: items.length,
          scrollDirection: Axis.horizontal,
          // itemBuilder: (BuildContext context, int index) {
          //   final item = store.procedures[index];
          children: [
        for (var item in items)
          SizedBox(
            width: 800 / items.length,
            child: Card(
              child: InkWell(
                onTap: () {
                  tapFunction(item, store, context);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(item.icon),
                    Text(
                      '${item.name}'.i18n,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
      ]));
}
