import 'package:restapp2/entitys/entity_add_review.dart';
import 'package:restapp2/repository/restaurant_repository_1.dart';

abstract class AddReviewCase {
  Future<EntityAddReview> addReview(
      String restaurantId, String userName, String review);
}

class AddReviewUseCaseImpl extends AddReviewCase {
  RestaurantRepository1 restaurantRepository;

  AddReviewUseCaseImpl({required this.restaurantRepository});

  @override
  Future<EntityAddReview> addReview(
          String restaurantId, String userName, String review) =>
      restaurantRepository.addReview(restaurantId, userName, review);
}
