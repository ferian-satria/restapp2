import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restapp2/bloc/fav_restaurant/fav_bloc.dart';
import 'package:restapp2/demo/restaurant_details_scr.dart';
import 'package:restapp2/model/list_model.dart';
import 'package:restapp2/sourcedata/api.dart';
import 'package:restapp2/sourcedata/remote.dart';
import 'package:restapp2/repository/restaurant_repository.dart';
import 'package:restapp2/usecases/restaurant_details_use_case.dart';
import 'package:restapp2/external/colors_setting.dart';
import 'package:restapp2/external/image_set.dart';
import 'package:restapp2/bloc/get_detail_restaurant_bloc.dart';
import 'package:restapp2/widgets/warn.dart';
import 'package:restapp2/widgets/progress_load.dart';

class RestaurantDetailsScreen extends StatefulWidget {
  static const routeName = '/restaurant_details_screen';
  final RestaurantModel detailRestaurant;
  const RestaurantDetailsScreen({super.key, required this.detailRestaurant});

  @override
  _RestaurantDetailsScreenState createState() =>
      _RestaurantDetailsScreenState();
}

class _RestaurantDetailsScreenState extends State<RestaurantDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetDetailRestaurantBloc(
          getRestaurantDetailUseCase: GetRestaurantDetailUseCaseImpl(
              restaurantRepository: RestaurantRepository(
                  remoteDataSource: RemoteDataSourceImpl(
                      dio: Dio(BaseOptions(baseUrl: Api.baseUrl))))))
        ..add(GetDetailRestaurant(restaurantId: widget.detailRestaurant.id)),
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (context, isScrolled) {
              print(
                  "gambar ini isisnya apasih ${widget.detailRestaurant.pictureId}");
              return [
                SliverAppBar(
                  backgroundColor: ColorsSet.sage,
                  pinned: true,
                  expandedHeight: 200.w,
                  iconTheme: const IconThemeData(color: ColorsSet.white),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Hero(
                      tag: widget.detailRestaurant.name,
                      child: Material(
                        color: Colors.transparent,
                        child: Image.network(
                          "https://restaurant-api.dicoding.dev/images/small/${widget.detailRestaurant.pictureId}",
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  ),
                  centerTitle: false,
                  title: Text(
                    widget.detailRestaurant.name,
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
                                    element.id == widget.detailRestaurant.id)) {
                                  int index = state.restaurant.indexWhere(
                                      (element) =>
                                          element.id ==
                                          widget.detailRestaurant.id);
                                  context.read<FavBloc>().add(DeleteTodo(
                                      id: state.restaurant[index].id));
                                  content = "Delete Favourite successfully";
                                } else {
                                  context.read<FavBloc>().add(
                                        AddRestaurant(
                                          city: widget.detailRestaurant.city,
                                          description: widget
                                              .detailRestaurant.description,
                                          rating:
                                              widget.detailRestaurant.rating,
                                          pictureId:
                                              widget.detailRestaurant.pictureId,
                                          image:
                                              widget.detailRestaurant.pictureId,
                                          id: widget.detailRestaurant.id,
                                          name: widget.detailRestaurant.name,
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
                                        widget.detailRestaurant.id)
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
