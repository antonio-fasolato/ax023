import 'package:AX023/model/project_dao.dart';
import 'package:AX023/repositories/project_repository.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ProjectDialog extends StatelessWidget {
  final Function(ProjectDao project) _onSaved;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  ProjectDialog({super.key, required Function(ProjectDao project) onSaved})
      : _onSaved = onSaved;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: const Text("Nuovo progetto"),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: codeController,
                decoration: const InputDecoration(
                    labelText: "Commessa", icon: Icon(Icons.account_box)),
                validator: (value) {
                  if (value?.isEmpty ?? false) {
                    return "Codice commessa obbligatorio";
                  }
                  return null;
                },
              ),
              SizedBox(
                width: 400,
                child: TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                      labelText: "Nome progetto", icon: Icon(Icons.email)),
                  validator: (value) {
                    if (value?.isEmpty ?? false) {
                      return "Nome progetto obbligatorio";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        _formKey.currentState?.save();
                        ProjectDao project = ProjectDao(
                            id: const Uuid().v4(),
                            code: codeController.text,
                            description: nameController.text);
                        await (await ProjectRepository.getInstance())
                            .save(project);
                        _onSaved(project);
                        if (!context.mounted) return;
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text("Ok")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
