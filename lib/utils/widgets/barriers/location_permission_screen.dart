import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:location/location.dart';
import 'package:prasad/l10n/app_localizations.dart';
import 'package:prasad/utils/widgets/barriers/barrier_screen.dart';

class LocationPermissionScreen extends StatefulWidget {
  const LocationPermissionScreen({super.key, required this.child});

  final Widget child;

  @override
  State<LocationPermissionScreen> createState() =>
      _LocationPermissionScreenState();
}

class _LocationPermissionScreenState extends State<LocationPermissionScreen> {
  Future<PermissionStatus>? locationPermissionStatus;

  @override
  void initState() {
    super.initState();
    Location location = Location();
    locationPermissionStatus = location.hasPermission();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: locationPermissionStatus,
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.hasData) {
          if (asyncSnapshot.data! == PermissionStatus.granted) {
            return widget.child;
          } else {
            return BarrierScreen(
              barrierText: AppLocalizations.of(
                context,
              )!.provideLocationPermission,
              buttonText: AppLocalizations.of(context)!.grantPermission,
              onButtonPressed: () async {
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
                  permissionGranted = await location.requestPermission();
                  if (permissionGranted != PermissionStatus.granted) {
                    return;
                  }
                }

                setState(() {
                  locationPermissionStatus = location.hasPermission();
                });
              },
            );
          }
        } else {
          return SpinKitThreeBounce(
            size: 32,
            color: Theme.of(context).colorScheme.primary,
          );
        }
      },
    );
  }
}
