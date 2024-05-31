import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restapp2/demo/favorite.dart';
import 'package:restapp2/demo/restaurant_details_screen.dart';
import 'package:restapp2/demo/setting.dart';
import 'package:restapp2/sourcedata/api.dart';
import 'package:restapp2/sourcedata/remote.dart';
import 'package:restapp2/repository/restaurant_repository.dart';
import 'package:restapp2/direct/direct_restaurant_list.dart';
import 'package:restapp2/usecases/restaurant_list_use_case.dart';
import 'package:restapp2/external/colors_setting.dart';
import 'package:restapp2/external/image_set.dart';
import 'package:restapp2/bloc/get_list_restaurant_bloc.dart';
import 'package:restapp2/demo/restaurant_scr.dart';
import 'package:restapp2/utils/notification_helper.dart';
import 'package:restapp2/widgets/warn.dart';
import 'package:restapp2/widgets/progress_load.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final DirectRestaurantList _restaurantListRouter = DirectRestaurantListImpl();

  final NotificationHelper _notificationHelper = NotificationHelper();

  @override
  void initState() {
    super.initState();
    _notificationHelper
        .configureSelectNotificationSubject(RestaurantDetailsScreen.routeName);
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetListRestaurantBloc(
        getListRestaurantUseCase: RestaurantListUseCaseImpl(
          restaurantRepository: RestaurantRepository(
            remoteDataSource: RemoteDataSourceImpl(
              dio: Dio(
                BaseOptions(
                  baseUrl: Api.baseUrl,
                ),
              ),
            ),
          ),
        ),
      )..add(GetListRestaurant()),
      child: Scaffold(
          backgroundColor: ColorsSet.sage,
          appBar: AppBar(
            backgroundColor: ColorsSet.sage,
            elevation: 0.0,
            centerTitle: false,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Restaurant",
                  style: TextStyle(color: ColorsSet.white, fontSize: 20.sp),
                ),
                Text(
                  "Recommendation restaurant for you!",
                  style: TextStyle(color: ColorsSet.white, fontSize: 12.sp),
                )
              ],
            ),
            actions: [
              IconButton(
                onPressed: () =>
                    _restaurantListRouter.goToSearchRestaurant(context),
                icon: const Icon(
                  Icons.search,
                  color: ColorsSet.white,
                ),
              ),
              IconButton(
                  key: const Key('favIcon'),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (c) => const FavView()));
                  },
                  icon: const Icon(
                    Icons.favorite_rounded,
                    color: Colors.red,
                  )),
              IconButton(
                  key: const Key('settingIcon'),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (c) => const SettingView()));
                  },
                  icon: const Icon(
                    Icons.settings,
                    color: Colors.white,
                  ))
            ],
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            margin: EdgeInsets.only(top: 16.w),
            padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.w),
            // padding: EdgeInsets.all(16.w),
            decoration: const BoxDecoration(
              color: ColorsSet.sage1,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0),
              ),
            ),
            child: SingleChildScrollView(
              key: const Key('listRestaurant'),
              child: BlocBuilder<GetListRestaurantBloc, GetListRestaurantState>(
                builder: (context, state) {
                  if (state is GetListRestaurantLoadedState) {
                    if (state.listRestaurant.isEmpty) {
                      return Warning(
                        errorImage: ImageSet.empty,
                        errorMessage: "Restaurant data is empty",
                      );
                    } else {
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.listRestaurant.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              key: Key('restaurantItem_$index'),
                              onTap: () {
                                _restaurantListRouter.goToDetailListRestaurant(
                                    context, state.listRestaurant[index]);
                              },
                              child: RestaurantScr(
                                  restaurantEntity:
                                      state.listRestaurant[index]),
                            );
                          });
                    }
                  } else if (state is GetListRestaurantFailedState) {
                    return Warning(
                      errorImage: ImageSet.warning,
                      errorMessage: "An error occurred please try again later",
                    );
                  } else {
                    return const Center(child: ProgressLoad());
                  }
                },
              ),
            ),
          )),
    );
  }
}
