import 'package:consent_app/src/procedure_chooser_feature/procedure_item_list_view.i18n.dart';
import 'package:flutter/material.dart';
import '../../main.dart';

Center horizontalChooser(
  List<dynamic> items,
  Store store,
  BuildContext context,
  Function tapFunction,
) {
  return Center(
      child: GridView.count(
          primary: false,
          mainAxisSpacing: 30,
          crossAxisSpacing: 30,
          padding: const EdgeInsets.all(80),
          // Providing a restorationId allows the ListView to restore the
          // scroll position when a user leaves and returns to the app after it
          // has been killed while running in the background.
          restorationId: 'ProcedureListView',
          shrinkWrap: true,
          // itemCount: items.length,
          scrollDirection: Axis.horizontal,
          // itemBuilder: (BuildContext context, int index) {
          //   final item = store.procedures[index];
          crossAxisCount: 2,
          children: [
        for (var item in items)
          SizedBox(
            child: Card(
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  tapFunction(item, store, context);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      item.icon,
                      width: 140,
                      height: 140,
                    ),
                    Text('${item.name}'.i18n,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        )),
                  ],
                ),
              ),
            ),
          ),
      ]));
}
