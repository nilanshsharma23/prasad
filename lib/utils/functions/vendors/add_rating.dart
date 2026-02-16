import 'package:prasad/utils/classes/globals.dart';
import 'package:prasad/utils/classes/rating_object.dart';

Future<void> addRating(
  List<RatingObject> ratings,
  String uid,
  double rating,
) async {
  var nameData = await Globals.supabase
      .from('users')
      .select('name')
      .eq('user_id', Globals.supabase.auth.currentUser!.id)
      .single();

  RatingObject newRatingObject = RatingObject(
    raterName: nameData['name'],
    rating: rating,
  );

  List<Map<String, dynamic>> ratingsJson = List.generate(ratings.length, (
    index,
  ) {
    return ratings[index].toJson();
  });

  ratingsJson.add(newRatingObject.toJson());

  await Globals.supabase
      .from('vendors')
      .update({'ratings': ratingsJson})
      .eq('uid', uid);
}
