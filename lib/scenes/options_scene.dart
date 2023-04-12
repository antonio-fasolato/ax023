import 'package:AX023/components/bottom_navigation.dart';
import 'package:AX023/components/header.dart';
import 'package:flutter/material.dart';

class OptionsScene extends StatelessWidget {
  final String title;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
              TextFormField(
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
