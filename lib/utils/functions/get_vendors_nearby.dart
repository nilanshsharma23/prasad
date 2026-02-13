import 'package:flutter/widgets.dart';
import 'package:flutter_map_math/flutter_geo_math.dart';
import 'package:location/location.dart';
import 'package:prasad/utils/classes/globals.dart';
import 'package:prasad/utils/classes/vendor_object.dart';

Future<List<VendorObject>> getVendorsNearby() async {
  List<VendorObject> output = [];

  Location location = Location();
  LocationData locationData = await location.getLocation();

  Globals.currentLocation = locationData;

  var topPoint = FlutterMapMath.destinationPoint(
    locationData.latitude!,
    locationData.longitude!,
    5 * 1000,
    90,
  );

  var bottomPoint = FlutterMapMath.destinationPoint(
    locationData.latitude!,
    locationData.longitude!,
    5 * 1000,
    270,
  );

  var leftPoint = FlutterMapMath.destinationPoint(
    locationData.latitude!,
    locationData.longitude!,
    5 * 1000,
    180,
  );

  var rightPoint = FlutterMapMath.destinationPoint(
    locationData.latitude!,
    locationData.longitude!,
    5 * 1000,
    0,
  );

  var data = await Globals.supabase
      .from('vendors')
      .select()
      .gte('latitude', leftPoint.latitude)
      .lte('latitude', rightPoint.latitude)
      .gte('longitude', bottomPoint.longitude)
      .lte('longitude', topPoint.longitude);

  for (var vendor in data) {
    output.add(VendorObject.fromJson(vendor));
  }

  debugPrint(output.toString());

  return output;
}
