part of 'restaurant_details_scr.dart';

class ReviewsScreen extends StatelessWidget {
  final List<ConsumerReviewEntity> consumerReviews;
  final String restaurantId;
  final DirectRestaurantList _restaurantListRouter = DirectRestaurantListImpl();

  ReviewsScreen(
      {super.key, required this.consumerReviews, required this.restaurantId});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorsSet.sage1,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 32.w),
            child: ListView.builder(
                itemCount: consumerReviews.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.fromLTRB(8.w, 0.w, 8.w, 16.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 0.5),
                          blurRadius: 1.0,
                        ),
                      ],
                    ),
                    padding: EdgeInsets.fromLTRB(16.w, 16.w, 16.w, 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(consumerReviews[index].name,
                            style: TextStyle(
                                fontSize: 20.sp,
                                color: ColorsSet.sage,
                                fontWeight: FontWeight.bold)),
                        Text(consumerReviews[index].review,
                            style: TextStyle(
                                fontSize: 16.sp,
                                color: const Color.fromARGB(255, 221, 99, 18),
                                fontWeight: FontWeight.normal)),
                        Text(consumerReviews[index].date,
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.normal)),
                      ],
                    ),
                  );
                }),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: CButton(
              text: "Add Review",
              onTap: () =>
                  _restaurantListRouter.goToAddReview(context, restaurantId),
            ),
          ),
        ],
      ),
    );
  }
}
