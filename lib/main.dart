import 'package:AX023/configuration.dart';
import 'package:AX023/repositories/database_connection.dart';
import 'package:AX023/scenes/options_scene.dart';
import 'package:flutter/material.dart';
import 'scenes/main_scene.dart';
import 'scenes/projects_scene.dart';
import 'scenes/table_scene.dart';
import 'package:intl/intl_standalone.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  DatabaseConnection connection = await DatabaseConnection.getInstance();
  Configuration config = await Configuration.getInstance();
  findSystemLocale()
      .then((_) => initializeDateFormatting().then((_) => runApp(MyApp(
            config: config,
            connection: connection,
          ))));
}

class MyApp extends StatelessWidget {
  final Configuration config;
  final DatabaseConnection connection;

  const MyApp({super.key, required this.config, required this.connection});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AX023 ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        title: 'Consuntivazione mese di ',
        config: config,
        connection: connection,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  final Configuration config;
  final DatabaseConnection connection;

  const MyHomePage(
      {super.key,
      required this.title,
      required this.config,
      required this.connection});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
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
        '/projects': (BuildContext ctx) => ProjectsScene(title: widget.title),
        '/options': (BuildContext ctx) => OptionsScene(
              title: widget.title,
              config: widget.config,
              connection: widget.connection,
            ),
      },
      initialRoute: '/',
    );
  }
}
