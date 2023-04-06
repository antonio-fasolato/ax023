import 'package:flutter/material.dart';
import '../components/header.dart';
import '../components/bottom_navigation.dart';

class TableScene extends StatelessWidget {
  const TableScene({super.key, required this.title});

  final String title;

  List<DataColumn> _createColumns() {
    return [
      DataColumn(label: Text('ID')),
      DataColumn(label: Text('Book')),
      DataColumn(label: Text('Author'))
    ];
  }

  List<DataRow> _createRows() {
    return [
      DataRow(cells: [
        DataCell(Text('#100')),
        DataCell(Text('Flutter Basics')),
        DataCell(Text('David John'))
      ]),
      DataRow(cells: [
        DataCell(Text('#101')),
        DataCell(Text('Dart Internals')),
        DataCell(Text('Alex Wick'))
      ])
    ];
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
