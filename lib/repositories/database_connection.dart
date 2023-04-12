import 'dart:io';
import 'package:AX023/configuration.dart';
import 'package:logger/logger.dart';
import 'package:sqlite_wrapper/sqlite_wrapper.dart';
import 'package:path/path.dart' as p;

class DatabaseConnection {
  static final sqlWrapper = SQLiteWrapper();
  static final logger = Logger();
  DatabaseInfo? _databaseInfo;

  static final DatabaseConnection _instance = DatabaseConnection._internal();

  DatabaseConnection._internal();

  Future<void> reconnect() async {
    Configuration config = await Configuration.getInstance();

    _instance._databaseInfo = await SQLiteWrapper().openDB(config.databasePath);
    logger.d("Connected to database ${_instance._databaseInfo?.path}");

    String sql = """
      CREATE TABLE IF NOT EXISTS "month" (
        "year" integer NOT NULL,
        "month" integer NOT NULL,
        PRIMARY KEY ("year", "month")
      ); 
      """;
    logger.d(sql);
    await SQLiteWrapper().execute(sql);
    sql = """
        CREATE TABLE IF NOT EXISTS "project" (
          "id" varchar NOT NULL primary key,
          "code" varchar NOT NULL,
          "description" varchar not null,
          "special" int not null default(0),
          "color" int not null default(0)
        ); 
      """;
    logger.d(sql);
    await SQLiteWrapper().execute(sql);
  }

  static Future<DatabaseConnection> getInstance() async {
    if (_instance._databaseInfo == null) {
      await _instance.reconnect();
    }
    return _instance;
  }
}
