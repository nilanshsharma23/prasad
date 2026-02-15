import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:prasad/utils/classes/globals.dart';
import 'package:prasad/utils/functions/vendors/get_vendors_nearby.dart';
import 'package:prasad/utils/widgets/barriers/location_permission_screen.dart';
import 'package:prasad/utils/widgets/vendor_container.dart';

class VendorsPage extends StatelessWidget {
  const VendorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Vendors Near Me",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(
            Globals.supabase.auth.currentUser != null
                ? '/add-vendor'
                : '/sign-in',
          );
        },
        child: Icon(Icons.add),
      ),
      body: LocationPermissionScreen(
        child: FutureBuilder(
          future: getVendorsNearby(),
          builder: (context, asyncSnapshot) {
            if (asyncSnapshot.hasData) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    spacing: 16,
                    children: List.generate(asyncSnapshot.data!.length, (
                      index,
                    ) {
                      return VendorContainer(
                        vendorObject: asyncSnapshot.data![index],
                      );
                    }),
                  ),
                ),
              );
            } else {
              return Center(
                child: Container(
                  width: 128,
                  height: 128,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(100, 0, 0, 0),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: SpinKitThreeBounce(
                    size: 32,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
