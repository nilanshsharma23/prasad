import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';

class PickLocationPage extends StatelessWidget {
  const PickLocationPage({
    super.key,
    required this.currentLocation,
    required this.onLocationPicked,
  });

  final LatLong currentLocation;
  final void Function(PickedData pickedData) onLocationPicked;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pick Location")),
      body: FlutterLocationPicker(
        initPosition: currentLocation,
        loadingWidget: SpinKitThreeBounce(
          color: Theme.of(context).colorScheme.primary,
          size: 16,
        ),
        onPicked: (pickedData) {
          onLocationPicked(pickedData);
          Navigator.pop(context);
        },
        userAgent: 'Prasad/1.0.0 (piescrap23@gmail.com)',
        selectButtonConfiguration: SelectButtonConfiguration(
          selectedLocationButtonTextStyle: TextStyle(
            fontSize: 16,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          selectLocationButtonStyle: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(8),
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
