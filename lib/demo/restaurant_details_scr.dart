import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restapp2/bloc/fav_restaurant/fav_bloc.dart';
import 'package:restapp2/entitys/restaurant_entity.dart';
import 'package:restapp2/sourcedata/api.dart';
import 'package:restapp2/sourcedata/remote.dart';
import 'package:restapp2/repository/restaurant_repository.dart';
import 'package:restapp2/entitys/entity_restaurant_detail.dart';
import 'package:restapp2/usecases/restaurant_details_use_case.dart';
import 'package:restapp2/external/colors_setting.dart';
import 'package:restapp2/external/image_set.dart';
import 'package:restapp2/bloc/get_detail_restaurant_bloc.dart';
import 'package:restapp2/direct/direct_restaurant_list.dart';
import 'package:restapp2/widgets/warn.dart';
import 'package:restapp2/widgets/button.dart';
import 'package:restapp2/widgets/progress_load.dart';

part 'desc_scr.dart';
part 'food_scr.dart';
part 'drink_scr.dart';
part 'review_scr.dart';

class RestaurantDetailsScr extends StatefulWidget {
  final RestaurantEntity restaurantEntity;
  const RestaurantDetailsScr({super.key, required this.restaurantEntity});

  @override
  _RestaurantDetailsScrState createState() => _RestaurantDetailsScrState();
}

class _RestaurantDetailsScrState extends State<RestaurantDetailsScr> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetDetailRestaurantBloc(
          getRestaurantDetailUseCase: GetRestaurantDetailUseCaseImpl(
              restaurantRepository: RestaurantRepository(
                  remoteDataSource: RemoteDataSourceImpl(
                      dio: Dio(BaseOptions(baseUrl: Api.baseUrl))))))
        ..add(GetDetailRestaurant(restaurantId: widget.restaurantEntity.id)),
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (context, isScrolled) {
              return [
                SliverAppBar(
                  backgroundColor: ColorsSet.sage,
                  pinned: true,
                  expandedHeight: 200.w,
                  iconTheme: const IconThemeData(color: ColorsSet.white),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Hero(
                      tag: widget.restaurantEntity.name,
                      child: Material(
                        color: Colors.transparent,
                        child: Image.network(
                          widget.restaurantEntity.pictureId,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  ),
                  centerTitle: false,
                  title: Text(
                    widget.restaurantEntity.name,
                    style: TextStyle(
                        color: ColorsSet.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp),
                  ),
                  actions: [
                    // BlocProvider(
                    //     create: (context) => FavBloc().add(const FetchTodos()),
                    //     child: BlocListener<FavBloc, FavState>(
                    //       listener: (context, state) {},
                    //       child:
                    // BlocBuilder<FavBloc, FavState>(
                    //   builder: (context, state) {
                    //     if (state is RestaurantInitial) {
                    //       context.read<FavBloc>().add(const FetchTodos());
                    //     }
                    //     if (state is DisplayRestaurants) {
                    //       return IconButton(
                    //         onPressed: () {},
                    //         icon: const Icon(
                    //           Icons.favorite_border_rounded,
                    //           color: Colors.red,
                    //         ),
                    //       );
                    //     } else {
                    //       return const SizedBox();
                    //     }
                    //   },
                    // ),
                    // ),
                    // ),
                    BlocBuilder<FavBloc, FavState>(
                      builder: (context, state) {
                        if (state is RestaurantInitial) {
                          // return ErrorOutput(message: state.message);
                          context.read<FavBloc>().add(const FetchTodos());
                        }
                        if (state is DisplayRestaurants) {
                          return IconButton(
                              key: const Key('favIcon'),
                              onPressed: () {
                                String content = '';
                                if (state.restaurant.any((element) =>
                                    element.id == widget.restaurantEntity.id)) {
                                  int index = state.restaurant.indexWhere(
                                      (element) =>
                                          element.id ==
                                          widget.restaurantEntity.id);
                                  context.read<FavBloc>().add(DeleteTodo(
                                      id: state.restaurant[index].id));
                                  content = "Delete Favourite successfully";
                                } else {
                                  context.read<FavBloc>().add(
                                        AddRestaurant(
                                          city: widget.restaurantEntity.city,
                                          description: widget
                                              .restaurantEntity.description,
                                          rating:
                                              widget.restaurantEntity.rating,
                                          pictureId:
                                              widget.restaurantEntity.pictureId,
                                          image:
                                              widget.restaurantEntity.pictureId,
                                          id: widget.restaurantEntity.id,
                                          name: widget.restaurantEntity.name,
                                        ),
                                      );

                                  content = "added Favorite successfully";
                                  context
                                      .read<FavBloc>()
                                      .add(const FetchTodos());
                                }

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  duration: const Duration(seconds: 3),
                                  content: Text(content),
                                ));
                              },
                              icon: Icon(
                                state.restaurant.any((element) =>
                                        element.id ==
                                        widget.restaurantEntity.id)
                                    ? Icons.favorite
                                    : Icons.favorite_outline,
                                color: Colors.red,
                              ));
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                  ],
                  bottom: const TabBar(
                    isScrollable: true,
                    labelColor: ColorsSet.white,
                    indicatorColor: ColorsSet.sage1,
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    tabs: [
                      Tab(
                        text: "Description",
                      ),
                      Tab(
                        text: "Foods",
                      ),
                      Tab(
                        text: "Drinks",
                      ),
                      Tab(
                        text: "Reviews",
                      ),
                    ],
                  ),
                ),
              ];
            },
            body:
                BlocBuilder<GetDetailRestaurantBloc, GetDetailRestaurantState>(
                    builder: (context, state) {
              if (state is GetDetailRestaurantLoadedState) {
                return TabBarView(
                  children: [
                    DescriptionScreen(
                      restaurantEntity: state.detailRestaurant,
                    ),
                    FoodsScreen(
                      foods: state.detailRestaurant.menus.foods,
                    ),
                    DrinksScreen(
                      drinks: state.detailRestaurant.menus.drinks,
                    ),
                    ReviewsScreen(
                      consumerReviews: state.detailRestaurant.consumerReviews,
                      restaurantId: state.detailRestaurant.id,
                    )
                  ],
                );
              } else if (state is GetDetailRestaurantFailedState) {
                return Scaffold(
                  appBar: AppBar(
                    backgroundColor: ColorsSet.sage,
                    iconTheme: const IconThemeData(color: ColorsSet.white),
                  ),
                  body: Warning(
                    errorImage: ImageSet.warning,
                    errorMessage: "An error occurred please try again later",
                  ),
                );
              } else {
                return const ProgressLoad();
              }
            }),
          ),
        ),
      ),
    );
  }
}
