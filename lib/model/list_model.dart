import 'package:equatable/equatable.dart';

class RestaurantListModel extends Equatable {
  final bool error;
  final String message;
  final int count;
  final int found;
  final List<RestaurantModel> restaurants;

  const RestaurantListModel({
    required this.restaurants,
    required this.error,
    required this.message,
    required this.count,
    required this.found,
  });

  @override
  List<Object> get props => [restaurants, error, message, count, found];

  factory RestaurantListModel.fromJson(Map<String, dynamic> json) =>
      RestaurantListModel(
        error: json['error'],
        message: json['message'] ?? "",
        count: json['count'] ?? 0,
        found: json['found'] ?? 0,
        restaurants: List<RestaurantModel>.from(json['restaurants']
            .map((restaurant) => RestaurantModel.fromJson(restaurant))),
      );
}

class RestaurantModel extends Equatable {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  // final String image;
  final double rating;

  const RestaurantModel({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    // required this.image,
  });

  @override
  List<Object> get props => [
        id, name, description, pictureId, city, rating,
        //  image
      ];

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      RestaurantModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        pictureId: json['pictureId'],
        city: json['city'],
        // image: json['image'],
        rating: json['rating'].toDouble(),
      );
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'pictureId': pictureId,
      'city': city,
      'rating': rating,
      // 'image': image,
    };
  }

  RestaurantModel copy({
    String? id,
    String? name,
    double? rating,
    String? description,
    String? city,
    String? pictureId,
    // String? image,
  }) =>
      RestaurantModel(
          id: id ?? this.id,
          name: name ?? this.name,
          description: description ?? this.description,
          rating: rating ?? this.rating,
          city: city ?? this.city,
          // image: image ?? this.image,
          pictureId: pictureId ?? this.pictureId);
}
