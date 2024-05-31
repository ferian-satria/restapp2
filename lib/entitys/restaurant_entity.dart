import 'package:equatable/equatable.dart';

class RestaurantListEntity extends Equatable {
  final bool error;
  final String message;
  final List<RestaurantEntity> restaurants;

  const RestaurantListEntity({
    required this.restaurants,
    required this.message,
    required this.error,
  });

  @override
  List<Object> get props => [restaurants, message, error];
}

class RestaurantEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;

  const RestaurantEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  @override
  List<Object> get props => [id, name, description, pictureId, city, rating];
}
