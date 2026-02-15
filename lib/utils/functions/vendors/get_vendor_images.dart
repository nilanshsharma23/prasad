import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:prasad/utils/classes/globals.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<List<Uint8List>> getVendorImages({required String uid}) async {
  List<Uint8List> output = [];

  final List<FileObject> objects = await Globals.supabase.storage
      .from('vendors')
      .list(path: uid);

  for (var i = 0; i < objects.length; i++) {
    debugPrint("$uid/${objects[i].name}");

    output.add(
      await Globals.supabase.storage
          .from('vendors')
          .download("$uid/${objects[i].name}"),
    );
  }

  return output;
}
