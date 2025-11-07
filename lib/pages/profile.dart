import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:prasad/utils/classes/globals.dart';
import 'package:prasad/utils/functions/get_profile_info.dart';
import 'package:prasad/utils/widgets/barriers/sign_in_barrier_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignInBarrierScreen(
        child: FutureBuilder(
          future: getProfileInfo(userId: Globals.supabase.auth.currentUser!.id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: EdgeInsetsGeometry.all(32),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 16,
                    children: [
                      Text(snapshot.data!.name, style: TextStyle(fontSize: 32)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Bhandaras Hosted: ",
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            snapshot.data!.numberOfListings.toString(),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "Thanks for hosting with us!",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
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
      ),
    );
  }
}
