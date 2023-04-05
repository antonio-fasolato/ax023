import 'package:flutter/material.dart';

class BottomNavigation {
  static Widget build(BuildContext context) {
    return BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: Colors.blue,
        child: IconTheme(
          data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
          child: Row(
            children: <Widget>[
              IconButton(
                tooltip: "Home",
                icon: const Icon(Icons.home_outlined),
                onPressed: () {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text("Home")));
                },
              ),
              IconButton(
                tooltip: "Progetti",
                icon: const Icon(Icons.folder_outlined),
                onPressed: () {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text("Progetti")));
                },
              ),
            ],
          ),
        ));
  }
}
