import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restapp2/model/list_model.dart';
import '/services/sqflite_service.dart';

part 'fav_event.dart';
part 'fav_state.dart';

class FavBloc extends Bloc<FavEvent, FavState> {
  FavBloc() : super(RestaurantInitial()) {
    List<RestaurantModel> favRestaurant = [];
    on<AddRestaurant>((event, emit) async {
      await DatabaseService.instance.create(RestaurantModel(
        id: event.id,
        name: event.name,
        description: event.description!,
        rating: event.rating!,
        pictureId: event.pictureId!,
        city: event.city!,
      ));
    });

    on<UpdateTodo>((event, emit) async {
      await DatabaseService.instance.update(
        data: event.todo,
      );
    });

    on<FetchTodos>((event, emit) async {
      emit(DisplayRestaurantsLoading());
      favRestaurant = await DatabaseService.instance.readAllTodos();
      emit(DisplayRestaurants(restaurant: favRestaurant));
    });

    on<FetchSpecificTodo>((event, emit) async {
      emit(DisplayRestaurantsLoading());
      RestaurantModel todo =
          await DatabaseService.instance.readTodo(id: event.id);
      emit(DisplaySpecificRestaurant(restaurant: todo));
    });

    on<DeleteTodo>((event, emit) async {
      await DatabaseService.instance.delete(id: event.id);
      add(const FetchTodos());
    });
  }
}
