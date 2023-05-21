import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'main.dart';
import 'dart:developer' as developer;

class Setting {
  final String name;
  final String value;

  const Setting({required this.name, required this.value});

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'value': value,
    };
  }

  @override
  String toString() {
    return 'Setting{id: $name, : $value}';
  }
}
void _createDb(Database db, int newVersion) async {
  developer.log('create table settings');
  // await db.execute(
  //     'DROP TABLE IF EXISTS settings;'
  // );
  // await db.execute(
  //     'DROP TABLE IF EXISTS feedback;'
  // );
  await db.execute(
      'CREATE TABLE settings(id integer primary key autoincrement , name TEXT UNIQUE, value TEXT);'
  );
  developer.log('create table feedback');
  await db.execute(
    'CREATE TABLE feedback(id integer primary key autoincrement , '
        'survey TEXT, '
        'videos TEXT, '
        'language TEXT, '
        'ts TIMESTAMP DEFAULT (CURRENT_TIMESTAMP) NOT NULL,'
        'synced INTEGER default 0 );',
  );
}
Future<Database> initDb() async {
  var dbLocation = (join(await getDatabasesPath(), 'consent.sqlite'));
  developer.log('dbLocation: $dbLocation');
  print('dbLocation: $dbLocation');
  final Database database = await openDatabase(
    dbLocation,
    onCreate: (db, version) {
      developer.log('creating database');
      _createDb(db, version);
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
  developer.log('inserting setting: $setting');
  db.insert(
    'settings',
    setting.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}
Future<List<Map>> getUnsyncedFeedback() async {
  Store store = locator<Store>();
  Database db = await store.database;
  List<Map> result = await db.rawQuery('SELECT * FROM feedback WHERE synced=?', [0]);
  developer.log('result: $result');
  return result;
  }
Future<List<Map>> updateAllSurveyData(List<dynamic> ids) async {
  Store store = locator<Store>();
  Database db = await store.database;
  for (var id in ids) {
    developer.log('updating id: $id');
    List<Map> result = await db.rawQuery('''update feedback set synced=1 
    WHERE id=?''', [id]);
    developer.log('result: $result');
  }
  return [];
}
Future<void> insertFeedback(String feedback, String survey, String language) async {
  Store store = locator<Store>();
  Database db = await store.database;
  developer.log('inserting feedback: $feedback, $survey');
  db.insert(
    'feedback',
    {'survey': survey, 'videos': feedback, 'language': language},
    conflictAlgorithm: ConflictAlgorithm.ignore,
  );
}

Future<String> getSetting(String name) async {
  Store store = locator<Store>();
  Database db = await store.database;
  List<Map> result = await db.rawQuery(
      'SELECT value FROM settings'
      ' WHERE name=? LIMIT 1',
      [name]);
  try {
    return result[0]['value'];
  } catch (e) {
    return 'Unknown + $name';
  }
}

void ensureSetting(String name, String value) async {
  Store store = locator<Store>();
  Database db = await store.database;
  var result = await db.rawQuery(
      'INSERT OR IGNORE INTO settings(name,value) VALUES(?,?)', [name, value]);
  // developer.log the results
  developer.log('result: $result');

}
