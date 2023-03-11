import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'main.dart';

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

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Setting{id: $name, : $value}';
  }
}
void _createDb(Database db, int newVersion) async {
  print('create table settings');
  // await db.execute(
  //     'DROP TABLE IF EXISTS settings;'
  // );
  // await db.execute(
  //     'DROP TABLE IF EXISTS feedback;'
  // );
  await db.execute(
      'CREATE TABLE settings(id integer primary key autoincrement , name TEXT UNIQUE, value TEXT);'
  );
  print('create table feedback');
  await db.execute(
    'CREATE TABLE feedback(id integer primary key autoincrement , '
        'survey TEXT, '
        'videos TEXT, '
        'ts TIMESTAMP DEFAULT (CURRENT_TIMESTAMP) NOT NULL,'
        'synced INTEGER default 0 );',
  );
}
Future<Database> initDb() async {
  var dbLocation = (join(await getDatabasesPath(), 'consent.sqlite'));
  print('dbLocation: $dbLocation');
  final Database database = await openDatabase(
    dbLocation,
    onCreate: (db, version) {
      print('creating database');
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
  print('inserting setting: $setting');
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
  print('result: $result');
  return result;
  }
Future<List<Map>> updateAllSurveyData(List<dynamic> ids) async {
  Store store = locator<Store>();
  Database db = await store.database;
  for (var id in ids) {
    print('updating id: $id');
    List<Map> result = await db.rawQuery('''update feedback set synced=1 
    WHERE id=?''', [id]);
    print('result: $result');
  }
  return [];
}
Future<void> insertFeedback(String feedback, String survey) async {
  Store store = locator<Store>();
  Database db = await store.database;
  print('inserting feedback: $feedback, $survey');
  db.insert(
    'feedback',
    {'survey': survey, 'videos': feedback},
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
    return 'Unknown';
  }
}

void ensureSetting(String name, String value) async {
  Store store = locator<Store>();
  Database db = await store.database;
  var result = await db.rawQuery(
      'INSERT OR IGNORE INTO settings(name,value) VALUES(?,?)', [name, value]);
  // print the results
  print('result: $result');
}
