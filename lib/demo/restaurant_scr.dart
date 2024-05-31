import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restapp2/entitys/restaurant_entity.dart';
import 'package:restapp2/direct/direct_restaurant_list.dart';
import 'package:restapp2/external/colors_setting.dart';

class RestaurantScr extends StatelessWidget {
  final RestaurantEntity restaurantEntity;
  final DirectRestaurantList _restaurantListRouter = DirectRestaurantListImpl();

  RestaurantScr({super.key, required this.restaurantEntity});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(8.w, 8.w, 8.w, 0.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: const [
          BoxShadow(
            color: ColorsSet.sage2,
            offset: Offset(0.0, 0.5),
            blurRadius: 1.0,
          ),
        ],
      ),
      child: InkWell(
        onTap: () => _restaurantListRouter.goToDetailListRestaurant(
            context, restaurantEntity),
        child: Row(
          children: [
            Hero(
              tag: restaurantEntity.name,
              child: Material(
                color: Colors.transparent,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.network(
                    restaurantEntity.pictureId,
                    height: 90.w,
                    width: 125.w,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.w, 0.w, 16.w, 0.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      restaurantEntity.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ColorsSet.sage,
                          fontSize: 16.sp),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.pin_drop,
                            color: const Color.fromARGB(255, 207, 0, 0),
                            size: 16.w,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 8.w),
                            child: Text(restaurantEntity.city,
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: ColorsSet.sage,
                                    fontSize: 14.sp)),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 16.w,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 8.w),
                            child: Text(restaurantEntity.rating.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: ColorsSet.sage,
                                    fontSize: 14.sp)),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
