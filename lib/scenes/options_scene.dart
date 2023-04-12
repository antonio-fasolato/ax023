import 'package:AX023/components/bottom_navigation.dart';
import 'package:AX023/components/header.dart';
import 'package:flutter/material.dart';

class OptionsScene extends StatelessWidget {
  final String title;

  const OptionsScene({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(title: title),
      body: Text("Options"),
      bottomNavigationBar: BottomNavigation(
        title: title,
      ),
    );
  }
}
