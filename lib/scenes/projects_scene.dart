import 'package:AX023/repositories/project_repository.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';
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

  void _getProjects() async {
    List<ProjectDao> projects =
        await (await ProjectRepository.getInstance()).getAllProjects();
    setState(() {
      _projects = projects;
    });
  }

  List<Widget> _createCards() {
    return _projects.map((p) => ProjectCard(project: p)).toList();
  }

  Future<void> _addProject() async {
    ProjectDao project = ProjectDao(
        id: const Uuid().v4(), code: "NETPR035", description: "Swabmonitor");
    await (await ProjectRepository.getInstance()).save(project);
    setState(() {
      _projects.add(project);
    });
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
        onPressed: _addProject,
        tooltip: 'Increment',
        child: const Icon(Icons.add_task),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
