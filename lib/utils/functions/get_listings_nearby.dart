import 'package:flutter_map_math/flutter_geo_math.dart';
import 'package:location/location.dart';
import 'package:prasad/utils/classes/globals.dart';
import 'package:prasad/utils/classes/listing_object.dart';

Future<List<ListingObject>> getListingsNearby({
  required int distanceInKm,
}) async {
  List<ListingObject> output = [];

  Location location = Location();
  LocationData locationData = await location.getLocation();

  Globals.currentLocation = locationData;

  var topPoint = FlutterMapMath.destinationPoint(
    locationData.latitude!,
    locationData.longitude!,
    distanceInKm * 10,
    90,
  );

  var bottomPoint = FlutterMapMath.destinationPoint(
    locationData.latitude!,
    locationData.longitude!,
    distanceInKm * 10,
    270,
  );

  var leftPoint = FlutterMapMath.destinationPoint(
    locationData.latitude!,
    locationData.longitude!,
    distanceInKm * 10,
    180,
  );

  var rightPoint = FlutterMapMath.destinationPoint(
    locationData.latitude!,
    locationData.longitude!,
    distanceInKm * 10,
    0,
  );

  var data = await Globals.supabase
      .from('listings')
      .select()
      .gte('latitude', leftPoint.latitude)
      .lte('latitude', rightPoint.latitude)
      .gte('longitude', bottomPoint.longitude)
      .lte('longitude', topPoint.longitude)
      .eq('status', 'accepted');

  for (var listing in data) {
    output.add(ListingObject.fromJson(listing));
  }

  return output;
}
