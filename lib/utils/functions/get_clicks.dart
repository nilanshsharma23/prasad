import 'package:prasad/utils/classes/globals.dart';

Future<int> getClicks({required String uid}) async {
  final data = await Globals.supabase
      .from('listings')
      .select('clicks')
      .eq('uid', uid)
      .single();

  return data['clicks'];
}
