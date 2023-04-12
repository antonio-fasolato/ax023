import 'package:AX023/components/bottom_navigation.dart';
import 'package:AX023/components/header.dart';
import 'package:AX023/configuration.dart';
import 'package:AX023/repositories/database_connection.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class OptionsScene extends StatelessWidget {
  final String title;
  final Configuration config;
  final DatabaseConnection connection;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Logger logger = Logger();

  TextEditingController folderController = TextEditingController();

  OptionsScene(
      {super.key,
      required this.title,
      required this.config,
      required this.connection}) {
    folderController.text = config.databasePath;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(title: title),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      controller: folderController,
                      enabled: false,
                      decoration: const InputDecoration(
                          labelText: "Cartella del database",
                          icon: Icon(Icons.folder)),
                      validator: (value) {
                        if (value?.isEmpty ?? false) {
                          return "Inserire una cartella esistente";
                        }
                        return null;
                      },
                    ),
                  ),
                  IconButton(
                      onPressed: () async {
                        String? selectedPath = await FilePicker.platform
                            .saveFile(
                                dialogTitle: "Selezionare il file di database");
                        if (selectedPath != null) {
                          folderController.text = selectedPath;
                        }
                      },
                      icon: const Icon(Icons.more_horiz))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                      padding: const EdgeInsets.all(40),
                      child: ElevatedButton(
                          onPressed: () async {
                            config.databasePath = folderController.text;
                            await connection.reconnect();
                          },
                          child: const Text("Salva")))
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigation(
        title: title,
      ),
    );
  }
}
