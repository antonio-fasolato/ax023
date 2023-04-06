import 'package:flutter/material.dart';
import '../model/project_dao.dart';

class ProjectCard extends StatelessWidget {
  final ProjectDao project;

  const ProjectCard({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 2,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.task),
              title: Text(project.code),
              subtitle: Text(project.description),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                    onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Elimina progetto"))),
                    child: const Text("Elimina")),
                const SizedBox(
                  width: 8,
                ),
                TextButton(
                    onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Modifica progetto"))),
                    child: const Text("Modifica")),
                const SizedBox(
                  width: 8,
                ),
              ],
            ),
          ],
        ));
  }
}
