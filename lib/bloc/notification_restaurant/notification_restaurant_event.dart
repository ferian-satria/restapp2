part of 'notification_restaurant_bloc.dart';

sealed class NotificationRestaurantEvent extends Equatable {
  const NotificationRestaurantEvent();

  @override
  List<Object> get props => [];
}

final class GetDailyRestaurantPreferencesEvent
    extends NotificationRestaurantEvent {}

final class EnableDailyRestaurantEvent extends NotificationRestaurantEvent {
  final bool value;

  const EnableDailyRestaurantEvent({required this.value});
}

final class ScheduledRestaurantsEvent extends NotificationRestaurantEvent {
  final bool value;

  const ScheduledRestaurantsEvent({required this.value});
}
