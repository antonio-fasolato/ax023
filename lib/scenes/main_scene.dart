import 'package:flutter/material.dart';
import '../components/header.dart';
import '../components/bottom_navigation.dart';

class MainScene extends StatelessWidget {
  const MainScene({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header.build(context, title),
      body: const Center(
        child: Text("Home"),
      ),
      bottomNavigationBar: BottomNavigation(title: title),
    );
  }
}
