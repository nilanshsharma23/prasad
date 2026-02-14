import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';
import 'package:prasad/utils/classes/rating_object.dart';

class VendorObject {
  final String uid;
  final String name;
  final double rate;
  final List<String> services;
  final List<RatingObject> ratings;
  final LatLong latLong;

  const VendorObject({
    required this.uid,
    required this.name,
    required this.rate,
    required this.services,
    required this.ratings,
    required this.latLong,
  });

  factory VendorObject.fromJson(Map<String, dynamic> data) {
    List<RatingObject> ratings = [];

    for (var i = 0; i < data['ratings'].length; i++) {
      ratings.add(RatingObject.fromJson(data['ratings'][i]));
    }

    List<String> services = [];

    for (var i = 0; i < data['services'].length; i++) {
      services.add(data['services'][i]);
    }

    return VendorObject(
      uid: data['uid'],
      name: data['name'],
      rate: double.parse(data['rate'].toString()),
      latLong: LatLong(data['latitude'], data['longitude']),
      services: services,
      ratings: ratings,
    );
  }
}
