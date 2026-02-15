import 'package:flutter/material.dart';

class VendorPage extends StatelessWidget {
  const VendorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Vendor Name",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
