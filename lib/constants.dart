import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Constants {
  String _basePath = "";
  String _databaseName = "";

  Constants._create();

  static Future<Constants> create() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    Constants constants = Constants._create();

    constants._basePath = preferences.getString("basePath") ??
        (await getApplicationDocumentsDirectory()).path;
    constants._databaseName =
        preferences.getString("databaseName") ?? "ax023.sqlite";

    return constants;
  }

  String get basePath => _basePath;

  String get databaseName => _databaseName;
}
