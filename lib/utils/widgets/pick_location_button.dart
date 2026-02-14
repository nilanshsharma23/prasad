import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';
import 'package:prasad/l10n/app_localizations.dart';
import 'package:prasad/pages/pick_location.dart';

class PickLocationButton extends StatelessWidget {
  const PickLocationButton({
    super.key,
    required this.pickedLocationData,
    required this.onLocationPicked,
    this.onStart,
    this.onStop,
  });

  final PickedData? pickedLocationData;
  final void Function(PickedData value) onLocationPicked;
  final void Function()? onStart;
  final void Function()? onStop;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          if (onStart != null) {
            onStart!();
          }

          Location location = Location();
          LocationData locationData = await location.getLocation();

          Navigator.push(
            context.mounted ? context : context,
            MaterialPageRoute(
              builder: (context) => PickLocationPage(
                currentLocation: LatLong(
                  locationData.latitude!,
                  locationData.longitude!,
                ),
                onLocationPicked: onLocationPicked,
              ),
            ),
          );

          if (onStop != null) {
            onStop!();
          }
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(8),
            side: BorderSide(color: Theme.of(context).colorScheme.outline),
          ),
          shadowColor: Colors.transparent,
        ),
        child: Padding(
          padding: EdgeInsetsGeometry.all(16),
          child: Text(
            pickedLocationData != null
                ? pickedLocationData!.address
                : AppLocalizations.of(context)!.selectLocation,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
