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
                IconButton(
                    onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Elimina progetto"))),
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    )),
                IconButton(
                    onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Modifica progetto"))),
                    icon: const Icon(Icons.edit)),
              ],
            ),
          ],
        ));
  }
}
