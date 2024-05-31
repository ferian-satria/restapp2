import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:restapp2/bloc/get_list_restaurant_bloc.dart';
import 'package:restapp2/external/image_set.dart';
import 'package:restapp2/repository/restaurant_repository.dart';
import 'package:restapp2/services/preferences_provider.dart';
import 'package:restapp2/services/scheduling_provider.dart';
import 'package:restapp2/sourcedata/api.dart';
import 'package:restapp2/sourcedata/remote.dart';
import 'package:restapp2/usecases/restaurant_list_use_case.dart';
import 'package:restapp2/widgets/warn.dart';

class SettingView extends StatefulWidget {
  const SettingView({super.key});

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetListRestaurantBloc(
          getListRestaurantUseCase: RestaurantListUseCaseImpl(
              restaurantRepository: RestaurantRepository(
                  remoteDataSource: RemoteDataSourceImpl(
                      dio: Dio(BaseOptions(baseUrl: Api.baseUrl))))))
        ..add(GetListRestaurant()),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Setting'),
        ),
        body: Consumer<PreferencesProvider>(
          builder: (context, provider, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocBuilder<GetListRestaurantBloc, GetListRestaurantState>(
                builder: (context, state) {
                  if (state is GetListRestaurantLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is GetListRestaurantFailedState) {
                    return Warning(
                      errorImage: ImageSet.warning,
                      errorMessage: "An error occurred please try again later",
                    );
                  }
                  if (state is GetListRestaurantLoadedState) {
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Restaurant Notification'),
                      subtitle: const Text('Enable Notification'),
                      trailing: Consumer<SchedulingProvider>(
                        builder: (context, scheduled, _) {
                          return Switch.adaptive(
                            value: provider.isRestaurantNewsActive,
                            onChanged: (value) async {
                              scheduled.scheduledRestaurants(value);
                              provider.enableRestaurantsNews(value);
                            },
                          );
                        },
                      ),
                    );
                  }
                  return const Center(child: SizedBox());
                  // return Loading();
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
