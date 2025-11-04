import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map_math/flutter_geo_math.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:location/location.dart';
import 'package:prasad/utils/classes/globals.dart';
import 'package:prasad/utils/functions/get_listings_nearby.dart';
import 'package:prasad/utils/widgets/listing_container.dart';
import 'package:prasad/utils/widgets/barriers/location_permission_screen.dart';
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
          'assets/logo_white.svg',
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
      body: LocationPermissionScreen(
        child: Padding(
          padding: EdgeInsetsGeometry.all(32),
          child: FutureBuilder(
            future: getListingsNearby(distanceInKm: 2),
            builder: (context, asyncSnapshot) {
              if (asyncSnapshot.hasData) {
                List<double> distances = List.generate(
                  asyncSnapshot.data!.length,
                  (index) {
                    return FlutterMapMath.distanceBetween(
                      Globals.currentLocation!.latitude!,
                      Globals.currentLocation!.longitude!,
                      asyncSnapshot.data![index].latLong.latitude,
                      asyncSnapshot.data![index].latLong.longitude,
                      "kilometers",
                    );
                  },
                );

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 32,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        StatusContainer(
                          primaryColor: Theme.of(context).colorScheme.primary,
                          status: asyncSnapshot.data!.length.toString(),
                          subtext: "Nearby",
                        ),
                        StatusContainer(
                          primaryColor: Theme.of(context).colorScheme.secondary,
                          status:
                              "${distances.reduce(min).toStringAsFixed(2)}km",
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
                    Column(
                      spacing: 32,
                      children: List.generate(asyncSnapshot.data!.length, (
                        index,
                      ) {
                        return ListingContainer(
                          listingObject: asyncSnapshot.data![index],
                        );
                      }),
                    ),
                  ],
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
      ),
    );
  }
}
