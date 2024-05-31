import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restapp2/entitys/entity_restaurant_detail.dart';
import 'package:restapp2/usecases/restaurant_details_use_case.dart';

class GetDetailRestaurantBloc
    extends Bloc<GetDetailRestaurantEvent, GetDetailRestaurantState> {
  RestaurantDetailUseCase getRestaurantDetailUseCase;

  GetDetailRestaurantBloc({required this.getRestaurantDetailUseCase})
      : super(GetDetailRestaurantInitialState()) {
    on<GetDetailRestaurant>((event, emit) async {
      try {
        emit(GetDetailRestaurantLoadingState());
        final detailRestaurant = await getRestaurantDetailUseCase
            .getRestaurantDetail(event.restaurantId);
        if (detailRestaurant.error != true) {
          emit(GetDetailRestaurantLoadedState(
              detailRestaurant: detailRestaurant));
        } else {
          emit(GetDetailRestaurantFailedState(
              message: detailRestaurant.message));
        }
      } catch (e) {
        emit(GetDetailRestaurantFailedState(message: e.toString()));
      }
    });
  }
}

abstract class GetDetailRestaurantState extends Equatable {
  const GetDetailRestaurantState();
}

class GetDetailRestaurantInitialState extends GetDetailRestaurantState {
  @override
  List<Object> get props => [];
}

class GetDetailRestaurantLoadingState extends GetDetailRestaurantState {
  @override
  List<Object> get props => [];
}

class GetDetailRestaurantLoadedState extends GetDetailRestaurantState {
  final EntityRestaurantDetail detailRestaurant;

  GetDetailRestaurantLoadedState({required this.detailRestaurant});

  @override
  List<Object> get props => [detailRestaurant];
}

class GetDetailRestaurantFailedState extends GetDetailRestaurantState {
  final String message;

  GetDetailRestaurantFailedState({required this.message});

  @override
  List<Object> get props => [message];
}

abstract class GetDetailRestaurantEvent extends Equatable {
  const GetDetailRestaurantEvent();
}

class GetDetailRestaurant extends GetDetailRestaurantEvent {
  final String restaurantId;

  GetDetailRestaurant({required this.restaurantId});

  @override
  List<Object> get props => [restaurantId];
}
