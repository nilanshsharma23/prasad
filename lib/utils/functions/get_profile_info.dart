import 'package:prasad/utils/classes/globals.dart';
import 'package:prasad/utils/classes/profile_object.dart';

Future<ProfileObject> getProfileInfo({required String userId}) async {
  final nameData = await Globals.supabase
      .from('users')
      .select('name')
      .eq('user_id', userId)
      .single();

  final listings = await Globals.supabase
      .from('listings')
      .select()
      .eq('host', userId);

  print(listings);

  return ProfileObject(
    name: nameData['name'],
    numberOfListings: listings.length,
  );
}
