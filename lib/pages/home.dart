import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map_math/flutter_geo_math.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:prasad/utils/classes/globals.dart';
import 'package:prasad/utils/classes/listing_object.dart';
import 'package:prasad/utils/functions/get_listings_nearby.dart';
import 'package:prasad/utils/widgets/barriers/barrier_screen.dart';
import 'package:prasad/utils/widgets/listing_container.dart';
import 'package:prasad/utils/widgets/barriers/location_permission_screen.dart';
import 'package:prasad/utils/widgets/status_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<ListingObject>> getListingsNearbyFuture;

  @override
  void initState() {
    super.initState();
    getListingsNearbyFuture = getListingsNearby(distanceInKm: 1);
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
        scrolledUnderElevation: 0,
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 16, 32, 0),
                child: DropdownMenu<int>(
                  dropdownMenuEntries: [
                    DropdownMenuEntry(value: 1, label: "1 km"),
                    DropdownMenuEntry(value: 2, label: "2 km"),
                    DropdownMenuEntry(value: 5, label: "5 km"),
                    DropdownMenuEntry(value: 10, label: "10 km"),
                    DropdownMenuEntry(value: 20, label: "20 km"),
                  ],
                  initialSelection: 1,
                  label: Text("Distance"),
                  inputDecorationTheme: InputDecorationTheme(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  width: double.infinity,
                  onSelected: (value) {
                    setState(() {
                      getListingsNearbyFuture = getListingsNearby(
                        distanceInKm: value!,
                      );
                    });
                  },
                ),
              ),
              FutureBuilder(
                future: getListingsNearbyFuture,
                builder: (context, asyncSnapshot) {
                  if (asyncSnapshot.hasData) {
                    if (asyncSnapshot.data!.isNotEmpty) {
                      List<double> distances = List.generate(
                        asyncSnapshot.data!.length,
                        (index) {
                          return FlutterMapMath.distanceBetween(
                                Globals.currentLocation!.latitude!,
                                Globals.currentLocation!.longitude!,
                                asyncSnapshot.data![index].latLong.latitude,
                                asyncSnapshot.data![index].latLong.longitude,
                                "kilometers",
                              ) /
                              1000;
                        },
                      );

                      return Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 32,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                StatusContainer(
                                  primaryColor: Theme.of(
                                    context,
                                  ).colorScheme.primary,
                                  status: asyncSnapshot.data!.length.toString(),
                                  subtext: "Nearby",
                                ),
                                StatusContainer(
                                  primaryColor: Theme.of(
                                    context,
                                  ).colorScheme.secondary,
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
                              children: List.generate(
                                asyncSnapshot.data!.length,
                                (index) {
                                  return ListingContainer(
                                    listingObject: asyncSnapshot.data![index],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return BarrierScreen(
                        barrierText:
                            "No Bhandaras are available at this distance right now",
                        buttonText: "Reload",
                        onButtonPressed: () {
                          setState(() {
                            getListingsNearbyFuture = getListingsNearby(
                              distanceInKm: 10,
                            );
                          });
                        },
                      );
                    }
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
  }
}
