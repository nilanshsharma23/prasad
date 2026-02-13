import 'package:flutter/material.dart';
import 'package:prasad/utils/functions/get_vendors_nearby.dart';
import 'package:prasad/utils/widgets/vendor_container.dart';

class VendorsPage extends StatefulWidget {
  const VendorsPage({super.key});

  @override
  State<VendorsPage> createState() => _VendorsPageState();
}

class _VendorsPageState extends State<VendorsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Vendors Near Me",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder(
        future: getVendorsNearby(),
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.hasData) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(children: [VendorContainer()]),
              ),
            );
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
