import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restapp2/usecases/case_add_review.dart';

class AddReviewBloc extends Bloc<AddReviewEvent, AddReviewState> {
  AddReviewCase addReviewUseCase;

  AddReviewBloc({required this.addReviewUseCase})
      : super(AddReviewInitialState()) {
    on<AddReview>(
      (event, emit) async {
        emit(AddReviewLoadingState());
        if (event.userName.isNotEmpty && event.review.isNotEmpty) {
          var listRestaurant = await addReviewUseCase.addReview(
              event.restaurantId, event.userName, event.review);
          if (listRestaurant.error != true) {
            emit(AddReviewSuccessState());
          } else {
            emit(AddReviewFailedState());
          }
        } else if (event.userName.isEmpty) {
          emit(AddReviewNameEmptyState());
        } else if (event.review.isEmpty) {
          emit(AddReviewReviewEmptyState());
        }
      },
    );
  }
}

abstract class AddReviewState extends Equatable {
  const AddReviewState();
}

class AddReviewInitialState extends AddReviewState {
  @override
  List<Object> get props => [];
}

class AddReviewLoadingState extends AddReviewState {
  @override
  List<Object> get props => [];
}

class AddReviewSuccessState extends AddReviewState {
  @override
  List<Object> get props => [];
}

class AddReviewNameEmptyState extends AddReviewState {
  @override
  List<Object> get props => [];
}

class AddReviewReviewEmptyState extends AddReviewState {
  @override
  List<Object> get props => [];
}

class AddReviewFailedState extends AddReviewState {
  @override
  List<Object> get props => [];
}

abstract class AddReviewEvent extends Equatable {
  const AddReviewEvent();
}

class AddReview extends AddReviewEvent {
  final String restaurantId;
  final String userName;
  final String review;

  AddReview({
    required this.restaurantId,
    required this.userName,
    required this.review,
  });

  @override
  List<Object> get props => [restaurantId, userName, review];
}
