import 'package:prasad/utils/classes/globals.dart';
import 'package:prasad/utils/classes/listing_object.dart';

Future<List<ListingObject>> getMyListings() async {
  final data = await Globals.supabase
      .from('listings')
      .select()
      .eq('host', Globals.supabase.auth.currentUser!.id);

  List<ListingObject> output = [];

  for (var listing in data) {
    output.add(ListingObject.fromJson(listing));
  }

  return output;
}
