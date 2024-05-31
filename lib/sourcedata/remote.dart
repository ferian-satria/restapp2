import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:restapp2/sourcedata/api.dart';
import 'package:restapp2/model/add_review.dart';
import 'package:restapp2/model/detail_model.dart';
import 'package:restapp2/model/list_model.dart';
import 'package:http/http.dart' as http;

abstract class RemoteDataSource {
  Future<RestaurantListModel> getRestaurantList();

  Future<DetailModelRestaurant> getRestaurantDetail(String restaurantId);

  Future<RestaurantListModel> searchRestaurant(String restaurantName);

  Future<AddReviewsModel> addReview(
      String restaurantId, String userName, String review);
}

class RemoteDataSourceImpl extends RemoteDataSource {
  Dio dio;

  RemoteDataSourceImpl({required this.dio});

  @override
  Future<RestaurantListModel> getRestaurantList() async {
    try {
      Response _response = await dio.get(Api.listRestaurant);
      return RestaurantListModel.fromJson(_response.data);
    } on DioError catch (e) {
      return RestaurantListModel.fromJson(e.response!.data);
    }
  }

  @override
  Future<RestaurantListModel> searchRestaurant(String restaurantName) async {
    try {
      Response _response =
          await dio.get("${Api.searchRestaurant}$restaurantName");
      return RestaurantListModel.fromJson(_response.data);
    } on DioError catch (e) {
      return RestaurantListModel.fromJson(e.response!.data);
    }
  }

  @override
  Future<DetailModelRestaurant> getRestaurantDetail(String restaurantId) async {
    try {
      Response _response =
          await dio.get("${Api.detailRestaurant}$restaurantId");
      return DetailModelRestaurant.fromJson(_response.data);
    } on DioError catch (e) {
      return DetailModelRestaurant.fromJson(e.response!.data);
    }
  }

  @override
  Future<AddReviewsModel> addReview(
      String restaurantId, String userName, String review) async {
    try {
      var body = {"id": restaurantId, "name": userName, "review": review};
      var header = {"X-Auth-Token": "12345"};
      Response _response = await dio.post("${Api.reviewRestaurant}",
          data: body,
          options: Options(
            method: "POST",
            contentType: Headers.jsonContentType,
            headers: header,
          ));
      return AddReviewsModel.fromJson(_response.data);
    } on DioError catch (e) {
      return AddReviewsModel.fromJson(e.response!.data);
    }
  }
}

Future<RestaurantListModel> getListRestaurants(http.Client client) async {
  final response =
      await client.get(Uri.parse("https://restaurant-api.dicoding.dev/list"));

  try {
    if (response.statusCode == 200) {
      return RestaurantListModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('failed to load list restaurant');
    }
  } catch (e) {
    throw Exception();
  }
}
