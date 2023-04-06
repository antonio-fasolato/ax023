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

  List<ProjectDao> _createProjects() {
    return [
      const ProjectDao(code: "NETPR035", description: "Swabmonitor"),
      const ProjectDao(code: "OMIPR154", description: "Wiki Omicron"),
      const ProjectDao(code: "TORPR008", description: "Torta fase 2"),
      const ProjectDao(
          code: "OMIPR096",
          description: "Tavolo architetture - review infrastruttura"),
      const ProjectDao(code: "ITCPR009", description: "Assistenza Italiacamp"),
      const ProjectDao(code: "OMIPR154", description: "Gestione CV"),
      const ProjectDao(code: "OMIPR123", description: "Stageit"),
      const ProjectDao(code: "PDCPR001", description: "Crypto"),
      const ProjectDao(code: "OMIPR154", description: "Fermo attivita'"),
      const ProjectDao(
          code: "OMIPR154", description: "Netgenomics backup ambiente"),
      const ProjectDao(code: "OMIPR154", description: "ChatGPT"),
      const ProjectDao(code: "OMIPR124", description: "ESG - architettura"),
      const ProjectDao(code: "OMIPR125", description: "PMS"),
      const ProjectDao(code: "OMIPR126", description: "Edison DpassWeb"),
      const ProjectDao(
          code: "OMIPR127", description: "Italiacamp stima nuovo flusso"),
      const ProjectDao(code: "RECRUHO", description: "Colloqui"),
    ];
  }

  List<Widget> _createCards() {
    return _createProjects().map((p) => ProjectCard(project: p)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(title: title),
      body: Center(
        child: ListView(
          children: _createCards(),
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
