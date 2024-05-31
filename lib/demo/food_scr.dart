part of 'restaurant_details_scr.dart';

class FoodsScreen extends StatelessWidget {
  final List<FoodsEntity> foods;

  const FoodsScreen({super.key, required this.foods});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorsSet.sage1,
      child: ListView.builder(
          itemCount: foods.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.fromLTRB(16.w, 0.w, 16.w, 16.w),
              child: Text(
                foods[index].name,
                style: TextStyle(fontSize: 20.sp, color: ColorsSet.white),
              ),
            );
          }),
    );
  }
}
