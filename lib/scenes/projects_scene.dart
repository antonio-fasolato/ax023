import 'package:flutter/material.dart';
import '../components/header.dart';
import '../components/bottom_navigation.dart';
import '../components/project_card.dart';

class ProjectsScene extends StatelessWidget {
  const ProjectsScene({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(title: title),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const <Widget>[
            ProjectCard(),
            SizedBox(height: 8,),
            ProjectCard(),
            SizedBox(height: 8,),
            ProjectCard(),
            SizedBox(height: 8,),
            ProjectCard(),
            SizedBox(height: 8,),
            ProjectCard(),
            SizedBox(height: 8,),
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
