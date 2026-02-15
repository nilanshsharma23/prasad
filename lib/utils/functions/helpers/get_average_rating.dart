import 'package:prasad/utils/classes/rating_object.dart';

double getAverageRating(List<RatingObject> ratings) {
  double output = 0;

  if (ratings.isNotEmpty) {
    for (var i = 0; i < ratings.length; i++) {
      output += ratings[i].rating;
    }

    output /= ratings.length;
  }

  return output;
}
