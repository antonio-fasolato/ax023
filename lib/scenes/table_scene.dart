import 'package:flutter/material.dart';
import '../components/header.dart';
import '../components/bottom_navigation.dart';

class TableScene extends StatelessWidget {
  const TableScene({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        title: title,
      ),
      body: const Center(
        child: Text("Table"),
      ),
      bottomNavigationBar: BottomNavigation(
        title: title,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Action"))),
        tooltip: 'Increment',
        child: const Icon(Icons.edit),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
