import 'dart:math';
import 'package:flutter/material.dart';
import '../components/header.dart';
import '../components/bottom_navigation.dart';

class TableScene extends StatelessWidget {
  const TableScene({super.key, required this.title});

  final String title;

  List<DataColumn> _createColumns() {
    List<DataColumn> res = [];
    for (int i = 0; i < 31; i++) {
      res.add(DataColumn(label: Text("${i + 1}"), numeric: true));
    }

    return [
      const DataColumn(label: Text('Commessa e progetto')),
      const DataColumn(label: Text('Totale'), numeric: true),
      ...res
    ];
  }

  List<DataRow> _createRows() {
    var rng = Random();

    List<DataRow> res = [];
    for (int i = 0; i < 5; i++) {
      int total = 0;
      List<DataCell> cells = [];
      for (int j = 0; j < 31; j++) {
        int r = rng.nextInt(8);
        total += r;
        cells.add(DataCell(Text("$r")));
      }

      res.add(DataRow(cells: [
        DataCell(Text('Progetto ${i + 1}')),
        DataCell(Text("$total")),
        ...cells
      ]));
    }

    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        title: title,
      ),
      body: ListView(
        children: [
          DataTable(
            columns: _createColumns(),
            rows: _createRows(),
            columnSpacing: 10,
            showBottomBorder: true,
          )
        ],
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
