import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Configuration {
  late SharedPreferences _preferences;
  late String _databaseFolder;
  late String _databaseName;

  Configuration._internal();

  static Future<Configuration> getInstance() async {
    Configuration config = Configuration._internal();

    config._preferences = await SharedPreferences.getInstance();
    config._databaseFolder = config._preferences.getString("databaseFolder") ??
        (await getApplicationDocumentsDirectory()).path;
    config._databaseName =
        config._preferences.getString("databaseName") ?? "ax023.sqlite";

    return config;
  }

  String get databaseName => _databaseName;

  String get databaseFolder => _databaseFolder;

  set databaseName(String value) {
    _databaseName = value;
    _preferences.setString("databaseName", value);
  }

  set databaseFolder(String value) {
    _databaseFolder = value;
    _preferences.setString("databaseFolder", value);
  }
}
