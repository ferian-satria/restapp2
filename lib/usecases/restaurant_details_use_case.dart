import 'package:restapp2/entitys/entity_restaurant_detail.dart';
import 'package:restapp2/repository/restaurant_repository_1.dart';

abstract class RestaurantDetailUseCase {
  Future<EntityRestaurantDetail> getRestaurantDetail(String restaurantId);
}

class GetRestaurantDetailUseCaseImpl extends RestaurantDetailUseCase {
  RestaurantRepository1 restaurantRepository;

  GetRestaurantDetailUseCaseImpl({required this.restaurantRepository});

  @override
  Future<EntityRestaurantDetail> getRestaurantDetail(String restaurantId) =>
      restaurantRepository.getRestaurantDetail(restaurantId);
}
