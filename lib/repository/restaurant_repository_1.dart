import 'package:restapp2/entitys/entity_add_review.dart';
import 'package:restapp2/entitys/entity_restaurant_detail.dart';
import 'package:restapp2/entitys/restaurant_entity.dart';

abstract class RestaurantRepository1 {
  Future<RestaurantListEntity> RestaurantList();
  Future<EntityRestaurantDetail> getRestaurantDetail(String restaurantId);
  Future<RestaurantListEntity> searchRestaurant(String restaurantName);
  Future<EntityAddReview> addReview(
      String restaurantId, String userName, String review);
}
