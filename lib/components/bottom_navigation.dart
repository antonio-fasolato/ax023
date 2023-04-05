import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
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
                  Navigator.of(context).pushNamed("/");
                },
              ),
              IconButton(
                tooltip: "Progetti",
                icon: const Icon(Icons.folder_outlined),
                onPressed: () {
                  Navigator.of(context).pushNamed("/projects");
                },
              ),
            ],
          ),
        ));
  }
}
