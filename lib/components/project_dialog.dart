import 'package:AX023/model/project_dao.dart';
import 'package:AX023/repositories/project_repository.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';

class ProjectDialog {
  static final logger = Logger();

  static Future<void> addProject(
      BuildContext context, Function(ProjectDao project) callback) async {
    GlobalKey<FormState> key = GlobalKey<FormState>();

    TextEditingController codeController = TextEditingController();
    TextEditingController nameController = TextEditingController();

    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: const Text("Nuovo progetto"),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
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
                    SizedBox(
                      width: 400,
                      child: TextFormField(
                        controller: nameController,
                        decoration: const InputDecoration(
                            labelText: "Nome progetto",
                            icon: Icon(Icons.email)),
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
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
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
                              callback(project);
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
        });
  }
}
