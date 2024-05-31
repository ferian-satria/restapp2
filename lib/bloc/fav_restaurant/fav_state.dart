part of 'fav_bloc.dart';

abstract class FavState extends Equatable {
  const FavState();
}

class RestaurantInitial extends FavState {
  @override
  List<Object> get props => [];
}

class DisplayRestaurants extends FavState {
  final List<RestaurantModel> restaurant;

  const DisplayRestaurants({required this.restaurant});
  @override
  List<Object> get props => [restaurant];
}

class DisplaySpecificRestaurant extends FavState {
  final RestaurantModel restaurant;

  const DisplaySpecificRestaurant({required this.restaurant});
  @override
  List<Object> get props => [restaurant];
}

class DisplayRestaurantsLoading extends FavState {
  @override
  List<Object?> get props => [];
}
