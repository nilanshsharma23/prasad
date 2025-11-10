import 'package:prasad/utils/classes/globals.dart';

Future<void> deleteAccount({required String uid}) async {
  final listingUidData = await Globals.supabase
      .from('listings')
      .select('uid')
      .eq('host', uid);

  await Globals.supabase.storage
      .from('proofs')
      .remove(
        List.generate(listingUidData.length, (index) {
          return "$uid/${listingUidData[index]['uid']}.png";
        }),
      );

  await Globals.supabase.from('listings').delete().eq('host', uid);
  await Globals.supabase.from('users').delete().eq('user_id', uid);
  await Globals.supabase.rpc('delete_user');
  await Globals.supabase.auth.signOut();
}
