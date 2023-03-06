import 'package:drift/drift.dart';

// database class. They are used to open the database.
import 'dart:io';
import 'package:drift/native.dart';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
// this will generate a table called "todos" for us. The rows of that table will

// assuming that your file is called filename.dart. This will give an error at
// first, but it's needed for drift to know about the generated code
part 'filename.g.dart';

// To open the database, add these imports to the existing file defining the
// be represented by a class called "Todo".
class Todos extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text().withLength(min: 6, max: 32)();

  TextColumn get content => text().named('body')();

  IntColumn get category => integer().nullable()();
}

// This will make drift generate a class called "Category" to represent a row in
// this table. By default, "Categorie" would have been used because it only
//strips away the trailing "s" in the table name.
@DataClassName('Category')
class Categories extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get description => text()();
}

class SurveyData extends Table {
  IntColumn get id => integer().autoIncrement()();

  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();

  TextColumn get data => text()();
}

@DriftDatabase(tables: [Todos, Categories, SurveyData])
class MyDatabase extends _$MyDatabase {
  // we tell the database where to store the data with this constructor
  MyDatabase() : super(_openConnection());

  Future<List<Todo>> get allTodoEntries => select(todos).get();

  Future<List<SurveyDataData>> get allSurveyData => select(surveyData).get();

  // Future<List<SurveyDataData>> get allUnSyncedSurveys() async {
  //   return await select(surveyData)
  //     ..where((a) => a.isSynced.equals(false)).get();
  // }

  // you should bump this number whenever you change or add a table definition.
  // Migrations are covered later in the documentation.
  @override
  int get schemaVersion => 2;

  updateAllSurveyData(List unsyncedSurveysList) {
    List ids = unsyncedSurveysList.map((e) => e.id).toList();
    for (int id in ids) {
      (update(surveyData)..where((t) => t.id.equals(id))).write(
        const SurveyDataCompanion(
          isSynced: Value(true),
        ),
      );
    }
  }
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    print('Opening database at ${file.path}');
    return NativeDatabase.createInBackground(file);
  });
}
