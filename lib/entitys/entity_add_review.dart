import 'package:equatable/equatable.dart';

class EntityAddReview extends Equatable {
  final bool error;
  final String message;

  EntityAddReview({
    required this.error,
    required this.message,
  });

  @override
  List<Object> get props => [error, message];
}
