import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Configuration {
  late String _databaseFolder;
  late String _databaseName;

  Configuration._internal();

  static Future<Configuration> getInstance() async {
    Configuration config = Configuration._internal();

    SharedPreferences preferences = await SharedPreferences.getInstance();
    config._databaseFolder = preferences.getString("databaseFolder") ??
        (await getApplicationDocumentsDirectory()).path;
    config._databaseName =
        preferences.getString("databaseName") ?? "ax023.sqlite";

    return config;
  }

  String get databaseName => _databaseName;

  String get databaseFolder => _databaseFolder;
}
