import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';

class PickLocationPage extends StatefulWidget {
  const PickLocationPage({
    super.key,
    required this.currentLocation,
    required this.onLocationPicked,
  });

  final LatLong currentLocation;
  final void Function(PickedData pickedData) onLocationPicked;

  @override
  State<PickLocationPage> createState() => _PickLocationPageState();
}

class _PickLocationPageState extends State<PickLocationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pick Location")),
      body: FlutterLocationPicker(
        initPosition: widget.currentLocation,
        loadingWidget: SpinKitThreeBounce(
          color: Theme.of(context).colorScheme.primary,
          size: 16,
        ),
        onPicked: (pickedData) {
          widget.onLocationPicked(pickedData);
          Navigator.pop(context);
        },
        userAgent: 'Prasad/1.0.0 (piescrap23@gmail.com)',
      ),
    );
  }
}
