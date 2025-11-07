import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:prasad/utils/functions/get_my_listings.dart';
import 'package:prasad/utils/widgets/barriers/sign_in_barrier_screen.dart';
import 'package:prasad/utils/widgets/listing_container.dart';

class MyListingsPage extends StatelessWidget {
  const MyListingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignInBarrierScreen(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsetsGeometry.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "My Bhandaras",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                ),
                SizedBox(height: 32),
                FutureBuilder(
                  future: getMyListings(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        spacing: 16,
                        children: List.generate(snapshot.data!.length, (index) {
                          return ListingContainer(
                            listingObject: snapshot.data![index],
                            onStartToLoad: () {},
                            onStoppedLoading: () {},
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
