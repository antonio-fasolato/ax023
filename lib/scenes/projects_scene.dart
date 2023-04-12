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

  Future<void> _addProject() async {
    GlobalKey<FormState> key = GlobalKey<FormState>();

    TextEditingController codeController = TextEditingController();
    TextEditingController nameController = TextEditingController();

    String? x = await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: Text("Nuovo progetto"),
            content: Padding(
              padding: EdgeInsets.all(8.0),
              child: Form(
                key: key,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: codeController,
                      decoration: const InputDecoration(
                          labelText: "Commessa", icon: Icon(Icons.account_box)),
                      onSaved: (newValue) {
                        logger.d("Saved commessa: $newValue");
                      },
                      validator: (value) {
                        if (value?.isEmpty ?? false) {
                          return "Codice commessa obbligatorio";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                          labelText: "Nome progetto", icon: Icon(Icons.email)),
                      onSaved: (newValue) {
                        logger.d("Saved nome: $newValue");
                      },
                      validator: (value) {
                        if (value?.isEmpty ?? false) {
                          return "Nome progetto obbligatorio";
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16.0),
                      child: ElevatedButton(
                          onPressed: () async {
                            if (key.currentState?.validate() ?? false) {
                              key.currentState?.save();
                              ProjectDao project = ProjectDao(
                                  id: const Uuid().v4(),
                                  code: codeController.text,
                                  description: nameController.text);
                              await (await ProjectRepository.getInstance())
                                  .save(project);
                              setState(() {
                                _projects.add(project);
                              });
                              if (!context.mounted) return;
                              Navigator.of(context).pop("Test");
                            }
                          },
                          child: Text("Ok")),
                    )
                  ],
                ),
              ),
            ),
          );
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
        onPressed: _addProject,
        tooltip: 'Increment',
        child: const Icon(Icons.add_task),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
