part of 'fav_bloc.dart';

abstract class FavEvent extends Equatable {
  const FavEvent();

  // @override
  // List<Object> get props => [];
}
// String? id,
//     String? name,
//     double? rating,
//     String? description,
//     String? city,
//     String? pictureId,

class AddRestaurant extends FavEvent {
  final String id, name, image;
  final String? city, pictureId, description;
  final double? rating;

  const AddRestaurant({
    required this.id,
    this.pictureId,
    required this.name,
    required this.image,
    this.description,
    this.city,
    this.rating,
  });
  @override
  List<Object> get props => [name, image, id];
  // [rating, name, image, description, city, id, pictureId]
}

class UpdateTodo extends FavEvent {
  final RestaurantModel todo;
  const UpdateTodo({required this.todo});
  @override
  List<Object?> get props => [todo];
}

class FetchTodos extends FavEvent {
  const FetchTodos();

  @override
  List<Object?> get props => [];
}

class FetchSpecificTodo extends FavEvent {
  final String id;
  const FetchSpecificTodo({required this.id});

  @override
  List<Object?> get props => [id];
}

class DeleteTodo extends FavEvent {
  final String id;
  const DeleteTodo({required this.id});
  @override
  List<Object?> get props => [id];
}
