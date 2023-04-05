import 'package:flutter/material.dart';
import '../components/header.dart';
import '../components/bottom_navigation.dart';

class ProjectsScene extends StatelessWidget {
  const ProjectsScene({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(title: title),
      body: const Center(
        child: Text("Projects"),
      ),
      bottomNavigationBar: BottomNavigation(title: title),
    );
  }
}
