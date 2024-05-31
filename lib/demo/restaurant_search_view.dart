import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restapp2/sourcedata/api.dart';
import 'package:restapp2/sourcedata/remote.dart';
import 'package:restapp2/repository/restaurant_repository.dart';
import 'package:restapp2/usecases/restaurant_search_case.dart';
import 'package:restapp2/external/colors_setting.dart';
import 'package:restapp2/external/image_set.dart';
import 'package:restapp2/bloc/search_bloc.dart';
import 'package:restapp2/demo/restaurant_scr.dart';
import 'package:restapp2/widgets/warn.dart';
import 'package:restapp2/widgets/progress_load.dart';

class RestaurantSearchView extends StatefulWidget {
  @override
  _RestaurantSearchViewState createState() => _RestaurantSearchViewState();
}

class _RestaurantSearchViewState extends State<RestaurantSearchView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SearchRestaurantBloc(
              searchRestaurantUseCase: SearchRestaurantUseCaseImpl(
                restaurantRepository: RestaurantRepository(
                  remoteDataSource: RemoteDataSourceImpl(
                    dio: Dio(
                      BaseOptions(baseUrl: Api.baseUrl),
                    ),
                  ),
                ),
              ),
            )..add(
                SearchRestaurant(searchText: ""),
              ),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: ColorsSet.sage,
            elevation: 0.0,
            iconTheme: const IconThemeData(color: ColorsSet.white),
            title: BlocBuilder<SearchRestaurantBloc, SearchRestaurantState>(
                builder: (context, state) {
              return Container(
                foregroundDecoration: const BoxDecoration(),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: ColorsSet.white,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 20.w,
                        child: TextFormField(
                          autofocus: true,
                          maxLines: 1,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(8.w, 15.w, 8.w, 5.w),
                              border: InputBorder.none,
                              hintText: "Cari restaurant",
                              hintStyle:
                                  const TextStyle(color: Colors.black54)),
                          onChanged: (value) {
                            BlocProvider.of<SearchRestaurantBloc>(context).add(
                                SearchRestaurant(searchText: value.toString()));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
          body: SingleChildScrollView(
            child: BlocBuilder<SearchRestaurantBloc, SearchRestaurantState>(
              builder: (context, state) {
                if (state is SearchRestaurantLoadedState) {
                  if (state.listRestaurant.isEmpty) {
                    return Center(
                      child: Warning(
                        errorImage: ImageSet.empty,
                        errorMessage: "Restaurant not found",
                      ),
                    );
                  } else {
                    return Container(
                      padding: EdgeInsets.fromLTRB(16.w, 0.w, 16.w, 0.w),
                      decoration: const BoxDecoration(
                        color: ColorsSet.sage1,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40.0),
                          topRight: Radius.circular(40.0),
                        ),
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.listRestaurant.length,
                        itemBuilder: (context, index) {
                          return RestaurantScr(
                              restaurantEntity: state.listRestaurant[index]);
                        },
                      ),
                    );
                  }
                } else if (state is SearchRestaurantFailedState) {
                  return Warning(
                    errorImage: ImageSet.warning,
                    errorMessage: "An error occurred please try again later",
                  );
                } else {
                  return const ProgressLoad();
                }
              },
            ),
          ),
        ));
  }
}
