import 'package:flutter/material.dart';
import '../components/header.dart';
import '../components/bottom_navigation.dart';
import '../components/project_card.dart';
import '../model/project_dao.dart';

class ProjectsScene extends StatelessWidget {
  const ProjectsScene({super.key, required this.title});

  final String title;
  final ProjectDao project = const ProjectDao(
      code: "TORTPR001", description: "Analisi per Studio Torta");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(title: title),
      body: Center(
        child: ListView(
          children: <Widget>[
            ProjectCard(
              project: project,
            ),
            const SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(title: title),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Action"))),
        tooltip: 'Increment',
        child: const Icon(Icons.add_task),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
