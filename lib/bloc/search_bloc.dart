import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restapp2/entitys/restaurant_entity.dart';
import 'package:restapp2/usecases/restaurant_search_case.dart';

class SearchRestaurantBloc
    extends Bloc<SearchRestaurantEvent, SearchRestaurantState> {
  RestaurantSearchCase searchRestaurantUseCase;

  SearchRestaurantBloc({required this.searchRestaurantUseCase})
      : super(SearchRestaurantInitialState()) {
    on<SearchRestaurant>((event, emit) async {
      try {
        emit(SearchRestaurantLoadingState());
        final listRestaurant =
            await searchRestaurantUseCase.searchRestaurant(event.searchText);
        if (listRestaurant.error != true) {
          emit(SearchRestaurantLoadedState(
              listRestaurant: listRestaurant.restaurants));
        } else {
          emit(SearchRestaurantFailedState(message: listRestaurant.message));
        }
      } catch (e) {
        emit(SearchRestaurantFailedState(message: e.toString()));
      }
    });
  }
}

abstract class SearchRestaurantState extends Equatable {
  const SearchRestaurantState();
}

class SearchRestaurantInitialState extends SearchRestaurantState {
  @override
  List<Object> get props => [];
}

class SearchRestaurantLoadingState extends SearchRestaurantState {
  @override
  List<Object> get props => [];
}

class SearchRestaurantLoadedState extends SearchRestaurantState {
  final List<RestaurantEntity> listRestaurant;

  SearchRestaurantLoadedState({required this.listRestaurant});

  @override
  List<Object> get props => [listRestaurant];
}

class SearchRestaurantFailedState extends SearchRestaurantState {
  final String message;

  SearchRestaurantFailedState({required this.message});

  @override
  List<Object> get props => [message];
}

abstract class SearchRestaurantEvent extends Equatable {
  const SearchRestaurantEvent();
}

class SearchRestaurant extends SearchRestaurantEvent {
  final String searchText;

  SearchRestaurant({required this.searchText});

  @override
  List<Object> get props => [];
}
