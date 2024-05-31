import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restapp2/preferences/preferences_helper.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:restapp2/utils/background_service.dart';
import 'package:restapp2/utils/date_time_helper.dart';

part 'notification_restaurant_event.dart';
part 'notification_restaurant_state.dart';

class NotificationRestaurantBloc
    extends Bloc<NotificationRestaurantEvent, NotificationRestaurantState> {
  PreferencesHelper preferencesHelper;
  NotificationRestaurantBloc(this.preferencesHelper)
      : super(NotificationRestaurantInitial()) {
    on<GetDailyRestaurantPreferencesEvent>((event, emit) async {
      await preferencesHelper.isDailyRestaurantsActive;
    });

    on<EnableDailyRestaurantEvent>((event, emit) {
      preferencesHelper.setDailyRestaurants(event.value);
    });

    on<ScheduledRestaurantsEvent>((event, emit) async {
      bool isScheduled = event.value;

      if (isScheduled) {
        await AndroidAlarmManager.periodic(
          const Duration(hours: 24),
          1,
          BackgroundService.callback,
          startAt: DateTimeHelper.format(),
          exact: true,
          wakeup: true,
        );
      } else {
        await AndroidAlarmManager.cancel(1);
      }
    });
  }
}
