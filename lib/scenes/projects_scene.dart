import 'package:AX023/components/project_dialog.dart';
import 'package:AX023/repositories/project_repository.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import '../components/header.dart';
import '../components/bottom_navigation.dart';
import '../components/project_card.dart';
import '../model/project_dao.dart';

class ProjectsScene extends StatefulWidget {
  const ProjectsScene({super.key, required this.title});

  final String title;

  @override
  State createState() => _ProjectSceneState();
}

class _ProjectSceneState extends State<ProjectsScene> {
  List<ProjectDao> _projects = [];
  final logger = Logger();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getProjects();
    });
  }

  Future<void> _getProjects() async {
    List<ProjectDao> projects =
        await (await ProjectRepository.getInstance()).getAllProjects();
    setState(() {
      _projects = projects;
    });
  }

  List<Widget> _createCards() {
    return _projects
        .map((p) => ProjectCard(project: p, onDeleted: _deleteProject))
        .toList();
  }

  Future<void> _addProject(ProjectDao project) async {
    setState(() {
      _projects.add(project);
    });
  }

  Future<void> _deleteProject(ProjectDao p) async {
    await (await ProjectRepository.getInstance()).delete(p);
    await _getProjects();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(title: widget.title),
      body: Center(
        child: ListView(
          children: _createCards(),
        ),
      ),
      bottomNavigationBar: BottomNavigation(title: widget.title),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return ProjectDialog(onSaved: _addProject);
              });
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add_task),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
