import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restapp2/bloc/get_detail_restaurant_bloc.dart';
import 'package:restapp2/demo/review_add_view.dart';
import 'package:restapp2/demo/restaurant_details_scr.dart';
import 'package:restapp2/demo/restaurant_search_view.dart';
import 'package:restapp2/entitys/restaurant_entity.dart';

abstract class DirectRestaurantList {
  goToDetailListRestaurant(
      context,
      //  String restaurantId, String restaurantName,
      //     String restaurantImage
      RestaurantEntity restaurantEntity);

  goToSearchRestaurant(context);

  goToAddReview(context, String restaurantId);
}

class DirectRestaurantListImpl extends DirectRestaurantList {
  @override
  goToDetailListRestaurant(
          context,
          //  String restaurantId, String restaurantName,
          //         String restaurantImage
          RestaurantEntity restaurantEntity) =>
      Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 1000),
          pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) =>
              RestaurantDetailsScr(
            restaurantEntity: restaurantEntity,
            // restaurantId: restaurantId,
            // restaurantImage: restaurantImage,
            // restaurantName: restaurantName,
          ),
        ),
      );

  @override
  goToSearchRestaurant(context) => Navigator.push(
      context, MaterialPageRoute(builder: (context) => RestaurantSearchView()));

  @override
  goToAddReview(context, String restaurantId) => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ReviewAddView(restaurantId: restaurantId)))
      .then((value) => BlocProvider.of<GetDetailRestaurantBloc>(context)
          .add(GetDetailRestaurant(restaurantId: restaurantId)));
}
