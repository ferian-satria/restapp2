import 'package:restapp2/sourcedata/api.dart';
import 'package:restapp2/sourcedata/remote.dart';
import 'package:restapp2/entitys/entity_add_review.dart';
import 'package:restapp2/entitys/entity_restaurant_detail.dart';
import 'package:restapp2/entitys/restaurant_entity.dart';
import 'package:restapp2/repository/restaurant_repository_1.dart';

class RestaurantRepository extends RestaurantRepository1 {
  RemoteDataSource remoteDataSource;

  RestaurantRepository({required this.remoteDataSource});

  @override
  Future<RestaurantListEntity> RestaurantList() async {
    List<RestaurantEntity> listRestaurant = [];
    var restaurantData = await remoteDataSource.getRestaurantList();
    for (var restaurant in restaurantData.restaurants) {
      var restaurantEntity = RestaurantEntity(
          id: restaurant.id,
          name: restaurant.name,
          description: restaurant.description,
          pictureId: "${Api.smallImageResolution}${restaurant.pictureId}",
          city: restaurant.city,
          rating: restaurant.rating);
      listRestaurant.add(restaurantEntity);
    }

    var restaurantListEntity = RestaurantListEntity(
      error: restaurantData.error,
      message: restaurantData.message,
      restaurants: listRestaurant,
    );

    return restaurantListEntity;
  }

  @override
  Future<RestaurantListEntity> searchRestaurant(String restaurantName) async {
    List<RestaurantEntity> listRestaurant = [];
    listRestaurant.clear();
    var restaurantData =
        await remoteDataSource.searchRestaurant(restaurantName);
    for (var restaurant in restaurantData.restaurants) {
      var restaurantEntity = RestaurantEntity(
          id: restaurant.id,
          name: restaurant.name,
          description: restaurant.description,
          pictureId: "${Api.smallImageResolution}${restaurant.pictureId}",
          city: restaurant.city,
          rating: restaurant.rating);
      listRestaurant.add(restaurantEntity);
    }

    var restaurantListEntity = RestaurantListEntity(
      error: restaurantData.error,
      message: restaurantData.message,
      restaurants: listRestaurant,
    );

    return restaurantListEntity;
  }

  @override
  Future<EntityRestaurantDetail> getRestaurantDetail(
      String restaurantId) async {
    var restaurantData =
        await remoteDataSource.getRestaurantDetail(restaurantId);
    List<CategoryEntity> categoryList = [];
    for (var category in restaurantData.restaurant.categories) {
      var categoryEntity = CategoryEntity(name: category.name);
      categoryList.add(categoryEntity);
    }

    List<FoodsEntity> foodList = [];
    for (var food in restaurantData.restaurant.menus.foods) {
      var foodEntity = FoodsEntity(name: food.name);
      foodList.add(foodEntity);
    }

    List<DrinksEntity> drinkList = [];
    for (var drink in restaurantData.restaurant.menus.drinks) {
      var drinkEntity = DrinksEntity(name: drink.name);
      drinkList.add(drinkEntity);
    }

    List<ConsumerReviewEntity> consumerReviewList = [];
    for (var consumerReview in restaurantData.restaurant.consumerReviews) {
      var consumerReviewEntity = ConsumerReviewEntity(
          name: consumerReview.name,
          review: consumerReview.review,
          date: consumerReview.date);
      consumerReviewList.add(consumerReviewEntity);
    }

    var detailRestaurantEntity = EntityRestaurantDetail(
      error: restaurantData.error,
      message: restaurantData.message,
      id: restaurantData.restaurant.id,
      name: restaurantData.restaurant.name,
      description: restaurantData.restaurant.description,
      pictureId:
          "${Api.smallImageResolution}${restaurantData.restaurant.pictureId}",
      city: restaurantData.restaurant.city,
      address: restaurantData.restaurant.address,
      rating: restaurantData.restaurant.rating.toString(),
      categories: categoryList,
      menus: MenusEntity(
        foods: foodList,
        drinks: drinkList,
      ),
      consumerReviews: consumerReviewList,
    );
    return detailRestaurantEntity;
  }

  @override
  Future<EntityAddReview> addReview(
      String restaurantId, String userName, String review) async {
    var consumerReview =
        await remoteDataSource.addReview(restaurantId, userName, review);
    var consumerReviewEntity = EntityAddReview(
        error: consumerReview.error, message: consumerReview.message);

    return consumerReviewEntity;
  }
}
