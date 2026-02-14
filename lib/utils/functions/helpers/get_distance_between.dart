import 'package:flutter_map_math/flutter_geo_math.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';
import 'package:prasad/utils/classes/globals.dart';

double getDistanceBetween(LatLong latLong) {
  return FlutterMapMath.distanceBetween(
        Globals.currentLocation!.latitude!,
        Globals.currentLocation!.longitude!,
        latLong.latitude,
        latLong.longitude,
        "kilometers",
      ) /
      1000;
}
