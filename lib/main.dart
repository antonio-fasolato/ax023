import 'package:flutter/material.dart';
import 'scenes/main_scene.dart';
import 'scenes/projects_scene.dart';
import 'scenes/table_scene.dart';
import 'package:intl/intl_standalone.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite_wrapper/sqlite_wrapper.dart';
import 'package:AX023/model/month_dao.dart';

Future<void> main() async {
  final docDir = await getApplicationDocumentsDirectory();
  if (!await docDir.exists()) {
    await docDir.create(recursive: true);
  }
  final DatabaseInfo dbInfo =
      await SQLiteWrapper().openDB(p.join(docDir.path, "ax023.sqlite"));
  debugPrint("Database path ${dbInfo.path}");

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

  final sqlWrapper = SQLiteWrapper();

  final Map? todoMap = await sqlWrapper
      .query("SELECT * FROM todos WHERE id = 1", singleResult: true);
  debugPrint("todoMap $todoMap");

  List<MonthDao> projects = List<MonthDao>.from(
      await sqlWrapper.query("SELECT * FROM month", fromMap: MonthDao.fromMap));
  for (var p in projects) {
    debugPrint("Month $p");
  }

  // findSystemLocale().then(
  //     (_) => initializeDateFormatting().then((_) => runApp(const MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AX023 ',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Consuntivazione mese di '),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: widget.title,
      theme: ThemeData(primarySwatch: Colors.blue),
      routes: {
        '/': (BuildContext ctx) => MainScene(title: widget.title),
        '/table': (BuildContext ctx) => TableScene(title: widget.title),
        '/projects': (BuildContext ctx) => ProjectsScene(title: widget.title)
      },
      initialRoute: '/',
    );
  }
}
