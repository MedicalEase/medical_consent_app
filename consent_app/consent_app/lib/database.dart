import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'main.dart';

class Setting {
  final String name;
  final String value;

  const Setting({
    required this.name,
    required this.value
  });

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'value': value,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Setting{id: $name, : $value}';
  }
}

Future<Database> initDb() async {
  var dbLocation = (join(await getDatabasesPath(), 'consent.sqlite'));
  print('dbLocation: $dbLocation');
  final Database database = await openDatabase(
    dbLocation,
    onCreate: (db, version) {
      print('creating database');
      return db.execute(
        'CREATE TABLE settings(id integer primary key autoincrement , name TEXT UNIQUE, value TEXT)',
      );
    },
// Set the version. This executes the onCreate function and provides a
// path to perform database upgrades and downgrades.
    version: 2,
  );
return database;
}

Future<void> upsertSetting(Setting setting) async {
  Store store = locator<Store>();
  Database db = await store.database;
  print('inserting setting: $setting');
  // Insert the Dog into the correct table. You might also specify the
  // `conflictAlgorithm` to use in case the same dog is inserted twice.
  // In this case, replace any previous data.
  db.insert(
    'settings',
    setting.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}
Future<String> getSetting(String name) async {
  Store store = locator<Store>();
  Database db = await store.database;
  List<Map> result = await db.rawQuery('SELECT value FROM settings'
      ' WHERE name=? LIMIT 1', [name]);
  try {
  return result[0]['value'];
  } catch (e) {
    return 'Unknown';
  }
}
void ensureSetting(String name, String value) async {
  Store store = locator<Store>();
  Database db = await store.database;
   var result = await db.rawQuery('INSERT OR IGNORE INTO settings(name,value) VALUES(?,?)', [name, value]);
  // print the results
  print('result: $result');
}
