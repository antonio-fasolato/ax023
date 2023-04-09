import 'package:AX023/model/project_dao.dart';
import 'package:AX023/repositories/database_connection.dart';
import 'package:logger/logger.dart';
import 'package:sqlite_wrapper/sqlite_wrapper.dart';

class ProjectRepository {
  static final ProjectRepository _instance = ProjectRepository._internal();

  static Future<ProjectRepository> getInstance() async {
    await DatabaseConnection.getInstance();
    return _instance;
  }

  ProjectRepository._internal();

  final sqlWrapper = SQLiteWrapper();
  final logger = Logger();

  Future<List<ProjectDao>> getAllProjects() async {
    const String sql = "SELECT * FROM project";
    logger.d(sql);

    List<ProjectDao> res = List<ProjectDao>.from(
        await sqlWrapper.query(sql, fromMap: ProjectDao.fromMap));

    logger.v({"projects", res});
    return res;
  }
}
