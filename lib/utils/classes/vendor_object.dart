import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';
import 'package:prasad/utils/classes/rating_object.dart';

class VendorObject {
  final String uid;
  final String name;
  final String description;
  final String rate;
  final String mobile;
  final List<String> services;
  final List<RatingObject> ratings;
  final LatLong latLong;

  const VendorObject({
    required this.uid,
    required this.name,
    required this.rate,
    required this.mobile,
    required this.description,
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
      description: data['description'],
      rate: data['rate'],
      mobile: data['mobile'],
      latLong: LatLong(data['latitude'], data['longitude']),
      services: services,
      ratings: ratings,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> ratingsJson = List.generate(
      ratings.length,
      (index) => ratings[index].toJson(),
    );

    return {
      'name': name,
      'description': description,
      'services': services,
      'ratings': ratingsJson,
      'rate': rate,
      'mobile': mobile,
      'latitude': latLong.latitude,
      'longitude': latLong.longitude,
    };
  }
}
