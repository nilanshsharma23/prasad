import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:location/location.dart';
import 'package:prasad/utils/classes/listing_object.dart';
import 'package:prasad/utils/widgets/listing_container.dart';
import 'package:prasad/utils/widgets/status_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<PermissionStatus>? locationPermissionStatus;

  @override
  void initState() {
    super.initState();
    Location location = Location();
    locationPermissionStatus = location.hasPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset(
          'assets/images/logo_white.svg',
          semanticsLabel: "Prasad Logo",
          width: 128,
          colorFilter: ColorFilter.mode(
            Theme.of(context).colorScheme.primary,
            BlendMode.srcIn,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.push('/settings');
            },
            icon: Icon(Icons.settings_outlined),
          ),
        ],
      ),
      body: FutureBuilder(
        future: locationPermissionStatus,
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.done) {
            if (asyncSnapshot.data! == PermissionStatus.granted) {
              return Padding(
                padding: EdgeInsetsGeometry.all(32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 32,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        StatusContainer(
                          primaryColor: Theme.of(context).colorScheme.primary,
                          status: "10",
                          subtext: "Nearby",
                        ),
                        StatusContainer(
                          primaryColor: Theme.of(context).colorScheme.secondary,
                          status: "1.0km",
                          subtext: "Nearest",
                        ),
                      ],
                    ),
                    Text(
                      "Nearby Bhandaras",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    ListingContainer(
                      listingObject: ListingObject(
                        location: "Raj Nagar, Ghaziabad",
                        date: "Today",
                        time: "9:00AM - 5:00PM",
                        people: "100+",
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Padding(
                padding: EdgeInsetsGeometry.all(32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 32,
                  children: [
                    Text(
                      "You need to grant location permission in order to access the functionality of this app.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                    TextButton(
                      onPressed: () async {
                        Location location = Location();

                        bool serviceEnabled;
                        PermissionStatus permissionGranted;

                        serviceEnabled = await location.serviceEnabled();
                        if (!serviceEnabled) {
                          serviceEnabled = await location.requestService();
                          if (!serviceEnabled) {
                            return;
                          }
                        }

                        permissionGranted = await location.hasPermission();
                        if (permissionGranted == PermissionStatus.denied) {
                          permissionGranted = await location
                              .requestPermission();
                          if (permissionGranted != PermissionStatus.granted) {
                            return;
                          }
                        }

                        setState(() {
                          locationPermissionStatus = location.hasPermission();
                        });
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(8),
                        ),
                      ),
                      child: Text(
                        "Grant Permission",
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          } else {
            return SpinKitThreeBounce(
              size: 32,
              color: Theme.of(context).colorScheme.primary,
            );
          }
        },
      ),
    );
  }
}
