import 'package:AX023/components/bottom_navigation.dart';
import 'package:AX023/components/header.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class OptionsScene extends StatelessWidget {
  final String title;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Logger logger = Logger();

  OptionsScene({super.key, required this.title});

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
                        String? selectedDirectory = await FilePicker.platform
                            .getDirectoryPath(
                                dialogTitle:
                                    "Selezionare la cartella di salvataggio del database");
                        logger.d(selectedDirectory);
                      },
                      icon: const Icon(Icons.more_horiz))
                ],
              ),
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
