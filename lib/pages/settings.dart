import 'package:flutter/material.dart';

enum Theme {
  systemDefault("System Default"),
  light("Light"),
  dark("Dark");

  const Theme(this.label);
  final String label;
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: Column(children: []),
    );
  }
}
