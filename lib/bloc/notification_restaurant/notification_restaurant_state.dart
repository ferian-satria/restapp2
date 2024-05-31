part of 'notification_restaurant_bloc.dart';

sealed class NotificationRestaurantState extends Equatable {
  const NotificationRestaurantState();

  @override
  List<Object> get props => [];
}

final class NotificationRestaurantInitial extends NotificationRestaurantState {}
