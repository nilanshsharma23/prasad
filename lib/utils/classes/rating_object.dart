class RatingObject {
  final String raterName;
  final double rating;

  const RatingObject({required this.raterName, required this.rating});

  factory RatingObject.fromJson(Map<String, dynamic> data) {
    return RatingObject(raterName: data['rater_name'], rating: data['rating']);
  }

  Map<String, dynamic> toJson() {
    return {'rater_name': raterName, 'rating': rating};
  }
}
