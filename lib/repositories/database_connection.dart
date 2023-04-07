import 'dart:io';
import 'package:AX023/constants.dart';
import 'package:logger/logger.dart';
import 'package:sqlite_wrapper/sqlite_wrapper.dart';
import 'package:path/path.dart' as p;

class DatabaseConnection {
  static final sqlWrapper = SQLiteWrapper();
  static final logger = Logger();
  static final DatabaseConnection _instance = DatabaseConnection._internal();

  DatabaseConnection._internal();

  static Future<DatabaseConnection> getInstance() async {
    Constants constants = await Constants.create();

    final docDir = Directory(constants.basePath);
    if (!await docDir.exists()) {
      await docDir.create(recursive: true);
    }
    final DatabaseInfo dbInfo = await SQLiteWrapper()
        .openDB(p.join(docDir.path, constants.databaseName));
    logger.d("Database path ${dbInfo.path}");

    String sql = """
		CREATE TABLE IF NOT EXISTS "todos" (
          "id" integer PRIMARY KEY AUTOINCREMENT NOT NULL,
          "title" varchar(255) NOT NULL,
          "done" int default 0
        );""";
    await SQLiteWrapper().execute(sql);
    sql = """
    CREATE TABLE IF NOT EXISTS "month" (
      "year" integer NOT NULL,
      "month" integer NOT NULL,
      PRIMARY KEY ("year", "month")
    ); """;
    await SQLiteWrapper().execute(sql);

    return _instance;
  }
}
