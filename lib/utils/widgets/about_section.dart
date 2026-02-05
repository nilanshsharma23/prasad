import 'package:flutter/widgets.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key, required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        Text(subtitle, style: TextStyle(fontSize: 16)),
      ],
    );
  }
}
