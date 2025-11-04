import 'package:flutter/material.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';
import 'package:prasad/utils/enums/status_enum.dart';

class ListingObject {
  final String address;
  final LatLong latLong;
  final DateTime date;
  final int people;
  final String uid;
  final TimeOfDay from;
  final TimeOfDay to;
  final String host;
  final Status status;

  const ListingObject({
    required this.address,
    required this.latLong,
    required this.date,
    required this.people,
    required this.from,
    required this.to,
    required this.uid,
    required this.host,
    required this.status,
  });

  factory ListingObject.fromJson(Map<String, dynamic> data) {
    return ListingObject(
      address: data['address'],
      latLong: LatLong(data['latitude'], data['longitude']),
      date: DateTime.parse(data['date']),
      people: data['people'],
      from: TimeOfDay(
        hour: int.parse(data['from'].split(":")[0]),
        minute: int.parse(data['from'].split(":")[1]),
      ),
      to: TimeOfDay(
        hour: int.parse(data['to'].split(":")[0]),
        minute: int.parse(data['to'].split(":")[1]),
      ),
      uid: data['uid'],
      host: data['host'],
      status: Status.fromString(data['status']),
    );
  }
}
