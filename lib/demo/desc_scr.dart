part of 'restaurant_details_scr.dart';

class DescriptionScreen extends StatelessWidget {
  final EntityRestaurantDetail restaurantEntity;

  const DescriptionScreen({super.key, required this.restaurantEntity});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorsSet.sage1,
      padding: EdgeInsets.only(left: 16.w, right: 16.w),
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.star,
                color: Colors.amber,
                size: 20.w,
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.w),
                child: Text(restaurantEntity.rating,
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: ColorsSet.white,
                        fontSize: 18.sp)),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.pin_drop,
                color: const Color.fromARGB(255, 207, 0, 0),
                size: 20.w,
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.w),
                child: Text(
                    "${restaurantEntity.address}, ${restaurantEntity.city}",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: ColorsSet.white,
                        fontSize: 16.sp)),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 16.w),
            child: Text(
              "Category",
              style: TextStyle(
                  color: ColorsSet.sage,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: 20.w,
            margin: EdgeInsets.only(top: 8.w),
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: restaurantEntity.categories.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(right: 8.w),
                    padding: EdgeInsets.fromLTRB(16.w, 0.w, 16.w, 0.w),
                    decoration: BoxDecoration(
                      color: ColorsSet.sage,
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 0.5),
                          blurRadius: 1.0,
                        ),
                      ],
                    ),
                    child: Text(
                      restaurantEntity.categories[index].name,
                      style: TextStyle(
                          fontSize: 16.sp,
                          color: ColorsSet.white,
                          fontWeight: FontWeight.normal),
                    ),
                  );
                }),
          ),
          Padding(
            padding: EdgeInsets.only(top: 16.w),
            child: Text(
              "Description",
              style: TextStyle(
                  color: ColorsSet.sage,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.w),
            child: Text(
              restaurantEntity.description,
              style: TextStyle(
                  color: ColorsSet.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.normal),
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }
}
