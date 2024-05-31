import 'package:restapp2/entitys/restaurant_entity.dart';
import 'package:restapp2/repository/restaurant_repository_1.dart';

abstract class RestaurantListUseCase {
  Future<RestaurantListEntity> RestaurantList();
}

class RestaurantListUseCaseImpl extends RestaurantListUseCase {
  RestaurantRepository1 restaurantRepository;

  RestaurantListUseCaseImpl({required this.restaurantRepository});

  @override
  Future<RestaurantListEntity> RestaurantList() =>
      restaurantRepository.RestaurantList();
}
