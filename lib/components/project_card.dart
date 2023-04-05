import 'package:flutter/material.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const ListTile(
          leading: Icon(Icons.task),
          title: Text("Titolo progetto"),
          subtitle: Text("Descrizione del progetto."),
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
