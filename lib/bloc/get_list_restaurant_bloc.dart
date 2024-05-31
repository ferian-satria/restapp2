import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restapp2/entitys/restaurant_entity.dart';
import 'package:restapp2/usecases/restaurant_list_use_case.dart';

class GetListRestaurantBloc
    extends Bloc<GetListRestaurantEvent, GetListRestaurantState> {
  RestaurantListUseCase getListRestaurantUseCase;

  GetListRestaurantBloc({required this.getListRestaurantUseCase})
      : super(GetListRestaurantInitialState()) {
    on<GetListRestaurant>(
      (event, emit) async {
        try {
          emit(GetListRestaurantLoadingState());
          final listRestaurant =
              await getListRestaurantUseCase.RestaurantList();
          if (listRestaurant.error != true) {
            emit(GetListRestaurantLoadedState(
                listRestaurant: listRestaurant.restaurants));
          } else {
            emit(GetListRestaurantFailedState(message: listRestaurant.message));
          }
        } catch (e) {
          emit(GetListRestaurantFailedState(message: e.toString()));
        }
      },
    );
  }
}

abstract class GetListRestaurantState extends Equatable {
  const GetListRestaurantState();
}

class GetListRestaurantInitialState extends GetListRestaurantState {
  @override
  List<Object> get props => [];
}

class GetListRestaurantLoadingState extends GetListRestaurantState {
  @override
  List<Object> get props => [];
}

class GetListRestaurantLoadedState extends GetListRestaurantState {
  final List<RestaurantEntity> listRestaurant;

  const GetListRestaurantLoadedState({required this.listRestaurant});

  @override
  List<Object> get props => [listRestaurant];
}

class GetListRestaurantFailedState extends GetListRestaurantState {
  final String message;

  const GetListRestaurantFailedState({required this.message});

  @override
  List<Object> get props => [message];
}

abstract class GetListRestaurantEvent extends Equatable {
  const GetListRestaurantEvent();
}

class GetListRestaurant extends GetListRestaurantEvent {
  @override
  List<Object> get props => [];
}
