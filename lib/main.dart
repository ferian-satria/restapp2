import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:restapp2/bloc/fav_restaurant/fav_bloc.dart';
import 'package:restapp2/bloc/notification/notification_bloc.dart';
import 'package:restapp2/demo/restaurant_details_screen.dart';
import 'package:restapp2/demo/restaurant_details_scrn.dart';
import 'package:restapp2/demo/splash_view.dart';
import 'package:restapp2/model/list_model.dart';
import 'package:restapp2/preferences/preferences_helper.dart';
import 'package:restapp2/services/preferences_provider.dart';
import 'package:restapp2/services/scheduling_provider.dart';
import 'package:restapp2/utils/background_service.dart';
import 'package:restapp2/utils/navigation.dart';
import 'package:restapp2/utils/notification_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();
  service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 640),
      builder: (context, child) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => FavBloc(),
          ),
          BlocProvider(
            create: (context) => NotificationBloc(),
          )
        ],
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => SchedulingProvider()),
            ChangeNotifierProvider(
              create: (_) => PreferencesProvider(
                preferencesHelper: PreferencesHelper(
                  sharedPreferences: SharedPreferences.getInstance(),
                ),
              ),
            ),
          ],
          child: MaterialApp(
            title: 'Restaurant App',
            debugShowCheckedModeBanner: false,
            navigatorKey: navigatorKey,
            theme: ThemeData(
              primarySwatch: Colors.orange,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            // home: MainView(),
            // home: const SplashScreen(),

            onGenerateRoute: (RouteSettings settings) {
              if (settings.name == '/') {
                return MaterialPageRoute(
                  builder: (context) => const SplashScreen(),
                  settings: const RouteSettings(name: '/'),
                );
              }

              if (settings.name == RestaurantDetailsScrn.routeName) {
                RestaurantModel restaurant =
                    settings.arguments as RestaurantModel;
                return MaterialPageRoute(
                  builder: (context) => RestaurantDetailsScrn(
                    detailRestaurant: restaurant,
                  ),
                  settings: const RouteSettings(
                      name: RestaurantDetailsScrn.routeName),
                );
              }

              if (settings.name == RestaurantDetailsScreen.routeName) {
                RestaurantModel restaurant =
                    settings.arguments as RestaurantModel;
                return MaterialPageRoute(
                  builder: (context) => RestaurantDetailsScreen(
                    detailRestaurant: restaurant,
                  ),
                  settings: const RouteSettings(
                      name: RestaurantDetailsScreen.routeName),
                );
              }
              return null;
            },
          ),
        ),
      ),
    );
  }
}
