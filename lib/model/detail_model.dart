import 'package:equatable/equatable.dart';

class DetailModelRestaurant extends Equatable {
  final bool error;
  final String message;
  final RestaurantData restaurant;

  const DetailModelRestaurant({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  @override
  List<Object> get props => [
        error,
        message,
        restaurant,
      ];

  factory DetailModelRestaurant.fromJson(Map<String, dynamic> json) =>
      DetailModelRestaurant(
        error: json['error'],
        message: json['message'],
        restaurant: RestaurantData.fromJson(json['restaurant']),
      );
}

class RestaurantData extends Equatable {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final String address;
  final String rating;
  final List<CategoryModel> categories;
  final MenusModel menus;
  final List<ConsumerReviewModel> consumerReviews;

  const RestaurantData({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.address,
    required this.rating,
    required this.categories,
    required this.menus,
    required this.consumerReviews,
  });

  @override
  List<Object> get props => [
        id,
        name,
        description,
        pictureId,
        city,
        address,
        rating,
        categories,
        menus,
        consumerReviews
      ];

  factory RestaurantData.fromJson(Map<String, dynamic> json) => RestaurantData(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        pictureId: json['pictureId'],
        city: json['city'],
        address: json['address'],
        rating: json['rating'].toString(),
        categories: List<CategoryModel>.from(json['categories']
            .map((category) => CategoryModel.fromJson(category))),
        menus: MenusModel.fromJson(json['menus']),
        consumerReviews: List<ConsumerReviewModel>.from(json['customerReviews']
            .map((consumerReview) =>
                ConsumerReviewModel.fromJson(consumerReview))),
      );
}

class CategoryModel extends Equatable {
  final String name;

  const CategoryModel({
    required this.name,
  });

  @override
  List<Object> get props => [name];

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      CategoryModel(name: json['name']);
}

class MenusModel extends Equatable {
  final List<FoodsModel> foods;
  final List<DrinksModel> drinks;

  const MenusModel({
    required this.foods,
    required this.drinks,
  });

  @override
  List<Object> get props => [foods, drinks];

  factory MenusModel.fromJson(Map<String, dynamic> json) => MenusModel(
        foods: List<FoodsModel>.from(
            json['foods'].map((food) => FoodsModel.fromJson(food))),
        drinks: List<DrinksModel>.from(
            json['drinks'].map((drink) => DrinksModel.fromJson(drink))),
      );
}

class FoodsModel extends Equatable {
  final String name;

  const FoodsModel({
    required this.name,
  });

  @override
  List<Object> get props => [name];

  factory FoodsModel.fromJson(Map<String, dynamic> json) =>
      FoodsModel(name: json['name']);
}

class DrinksModel extends Equatable {
  final String name;

  const DrinksModel({
    required this.name,
  });

  @override
  List<Object> get props => [name];

  factory DrinksModel.fromJson(Map<String, dynamic> json) =>
      DrinksModel(name: json['name']);
}

class ConsumerReviewModel extends Equatable {
  final String name;
  final String review;
  final String date;

  const ConsumerReviewModel({
    required this.name,
    required this.review,
    required this.date,
  });

  @override
  List<Object> get props => [name, review, date];

  factory ConsumerReviewModel.fromJson(Map<String, dynamic> json) =>
      ConsumerReviewModel(
        name: json['name'],
        review: json['review'],
        date: json['date'],
      );
}
