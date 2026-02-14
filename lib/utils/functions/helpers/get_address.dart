import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';

String getAddress(PickedData pickedLocationData) {
  String address = "";

  if (pickedLocationData.addressData['amenity'] != null) {
    address += "${pickedLocationData.addressData['amenity']}, ";
  }

  if (pickedLocationData.addressData['road'] != null) {
    address += "${pickedLocationData.addressData['road']}, ";
  }

  if (pickedLocationData.addressData['suburb'] != null) {
    address += "${pickedLocationData.addressData['suburb']}, ";
  }

  if (pickedLocationData.addressData['amenity'] != null) {
    address += "${pickedLocationData.addressData['city']}, ";
  }

  if (pickedLocationData.addressData['state'] != null) {
    address += "${pickedLocationData.addressData['state']}";
  }

  return address;
}
