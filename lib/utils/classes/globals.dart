import 'package:location/location.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Globals {
  static SupabaseClient supabase = Supabase.instance.client;
  static User? currentUser;
  static LocationData? currentLocation;
  static int currentColorScheme = 0;
}
