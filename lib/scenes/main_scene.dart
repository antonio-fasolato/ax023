import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../components/header.dart';
import '../components/bottom_navigation.dart';

class MainScene extends StatelessWidget {
  const MainScene({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(title: title),
      body: Center(
        child: TableCalendar(
          firstDay: DateTime.utc(2010, 10, 16),
          lastDay: DateTime.utc(2030, 3, 14),
          focusedDay: DateTime.now(),
          locale: 'it_IT',
          startingDayOfWeek: StartingDayOfWeek.monday,
        ),
      ),
      bottomNavigationBar: BottomNavigation(title: title),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Action"))),
        tooltip: 'Increment',
        child: const Icon(Icons.edit_calendar),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
