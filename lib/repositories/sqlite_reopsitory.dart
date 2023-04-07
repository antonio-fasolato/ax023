import 'package:AX023/model/month_dao.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite_wrapper/sqlite_wrapper.dart';

class SqliteRepository {
  static final SqliteRepository _instance = SqliteRepository._internal();

  factory SqliteRepository() {
    return _instance;
  }

  SqliteRepository._internal();

  final sqlWrapper = SQLiteWrapper();
  final logger = Logger();

  initDb() async {
    final docDir = await getApplicationDocumentsDirectory();
    if (!await docDir.exists()) {
      await docDir.create(recursive: true);
    }
    final DatabaseInfo dbInfo =
        await SQLiteWrapper().openDB(p.join(docDir.path, "ax023.sqlite"));
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
  }

  demo() async {
    final Map? todoMap = await sqlWrapper
        .query("SELECT * FROM todos WHERE id = 1", singleResult: true);
    logger.d("todoMap $todoMap");

    List<MonthDao> projects = List<MonthDao>.from(await sqlWrapper
        .query("SELECT * FROM month", fromMap: MonthDao.fromMap));
    logger.d({"Projects", projects});
  }
}
