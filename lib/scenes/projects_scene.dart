import 'package:flutter/material.dart';
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

  List<Widget> _createCards() {
    return _projects.map((p) => ProjectCard(project: p)).toList();
  }

  void _addProject() {
    setState(() {
      _projects.add(
        const ProjectDao(code: "NETPR035", description: "Swabmonitor"),
      );
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
