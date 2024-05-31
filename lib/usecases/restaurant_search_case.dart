import 'package:restapp2/entitys/restaurant_entity.dart';
import 'package:restapp2/repository/restaurant_repository_1.dart';

abstract class RestaurantSearchCase {
  Future<RestaurantListEntity> searchRestaurant(String restaurantName);
}

class SearchRestaurantUseCaseImpl extends RestaurantSearchCase {
  RestaurantRepository1 restaurantRepository;

  SearchRestaurantUseCaseImpl({required this.restaurantRepository});

  @override
  Future<RestaurantListEntity> searchRestaurant(String restaurantName) =>
      restaurantRepository.searchRestaurant(restaurantName);
}
