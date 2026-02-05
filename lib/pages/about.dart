import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("About Us")),
      body: Padding(
        padding: EdgeInsetsGeometry.all(32),
        child: Column(
          children: [
            Text(
              "Prasad",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
