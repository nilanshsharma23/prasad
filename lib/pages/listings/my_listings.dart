import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:prasad/l10n/app_localizations.dart';
import 'package:prasad/utils/classes/globals.dart';
import 'package:prasad/utils/functions/get_my_listings.dart';
import 'package:prasad/utils/widgets/barriers/barrier_screen.dart';
import 'package:prasad/utils/widgets/listing_container.dart';

class MyListingsPage extends StatelessWidget {
  const MyListingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (Globals.supabase.auth.currentUser != null) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsetsGeometry.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.myBhandaras,
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
      );
    } else {
      return BarrierScreen(
        barrierText: AppLocalizations.of(context)!.needToSignIn,
        buttonText: AppLocalizations.of(context)!.signIn,
        onButtonPressed: () {
          context.push('/sign-in');
        },
      );
    }
  }
}
