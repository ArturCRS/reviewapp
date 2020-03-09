import 'package:flutter_test/flutter_test.dart';
import '../lib/models/reviewmodel.dart';
import '../lib/models/reviews.dart';

void main() {
  test('Test MobX state class', () async {
    final Reviews _reviewsStore = Reviews();

    _reviewsStore.initReviews();

    expect(_reviewsStore.totalStars, 0);
    expect(_reviewsStore.averageStars, 0);

    _reviewsStore.addReview(ReviewModel(comment: "Test review", stars: 5));

    expect(_reviewsStore.totalStars, 5);

    _reviewsStore.addReview(ReviewModel(comment: "Test review 2", stars: 3));

    expect(_reviewsStore.averageStars, 4);
  });
}