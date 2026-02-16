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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              spacing: 32,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Vendors Near Me",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                ),
                FutureBuilder(
                  future: getVendorsNearby(),
                  builder: (context, asyncSnapshot) {
                    if (asyncSnapshot.hasData) {
                      return Column(
                        spacing: 16,
                        children: List.generate(asyncSnapshot.data!.length, (
                          index,
                        ) {
                          return VendorContainer(
                            vendorObject: asyncSnapshot.data![index],
                          );
                        }),
                      );
                    } else {
                      return Center(
                        child: SpinKitThreeBounce(
                          size: 32,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
