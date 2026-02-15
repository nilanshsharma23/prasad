import 'package:prasad/utils/classes/globals.dart';
import 'package:prasad/utils/classes/vendor_object.dart';

Future<VendorObject> getVendorDetails({required String uid}) async {
  var data = await Globals.supabase
      .from('vendors')
      .select()
      .eq('uid', uid)
      .single();

  return VendorObject.fromJson(data);
}
