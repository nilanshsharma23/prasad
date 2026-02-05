import 'package:prasad/utils/classes/globals.dart';

Future<void> setFcmToken(String fcmToken) async {
  if (Globals.supabase.auth.currentUser != null) {
    await Globals.supabase
        .from('users')
        .update({'fcm_token': fcmToken})
        .eq('user_id', Globals.supabase.auth.currentUser!.id);
  }
}
