import 'package:flutter/material.dart';

class Header {
  static PreferredSizeWidget build(BuildContext context, String title) {
    return AppBar(
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
    );
  }
}
