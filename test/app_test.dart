import 'package:flutter_test/flutter_test.dart';
import 'package:restapp2/main.dart' as app;
import 'robots/detail_restaurant_robot.dart';
import 'robots/list_favorite_robot.dart';
import 'robots/list_resturant_robot.dart';
import 'package:integration_test/integration_test.dart';
import 'robots/setting_robot.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  ListRestaurant listRestaurant;
  DetailRestaurant detailRestaurant;
  ListFavorite listFavorite;
  Setting setting;
  group('end to end test', () {
    testWidgets('whole app', (WidgetTester widgetTester) async {
      app.main();

      await widgetTester.pumpAndSettle();

      listRestaurant = ListRestaurant(widgetTester);
      detailRestaurant = DetailRestaurant(widgetTester);
      listFavorite = ListFavorite(widgetTester);
      setting = Setting(widgetTester);

      await listRestaurant.scrolllistRestaurant();
      await listRestaurant.scrolllistRestaurant(scrollUp: true);

      await listRestaurant.clickRestaurantItem();

      await detailRestaurant.clickFavIcon();

      await detailRestaurant.goBack();

      await listRestaurant.clickFavIcon();

      await listFavorite.removeFav();

      await listFavorite.goBack();

      await listRestaurant.clickSettingIcon();

      await setting.goBack();
    });
  });
}
