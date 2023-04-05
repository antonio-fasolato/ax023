import 'package:flutter/material.dart';

class MainScene extends StatelessWidget {
  const MainScene({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Mese precedente")));
              },
              icon: const Icon(Icons.arrow_left)),
          IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Mese successivo")));
              },
              icon: const Icon(Icons.arrow_right))
        ],
      ),
      body: const Center(
        child: Text("Home"),
      ),
      bottomNavigationBar: BottomAppBar(
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
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Progetti")));
                  },
                ),
              ],
            ),
          )),
    );
  }
}
