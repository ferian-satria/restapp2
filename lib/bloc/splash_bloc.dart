import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitialState()) {
    on<LoadSplashScreenEvent>(
      (event, emit) => emit(
        SplashLoadedState(),
      ),
    );
  }
}

abstract class SplashState extends Equatable {
  const SplashState();
}

class SplashInitialState extends SplashState {
  @override
  List<Object> get props => [];
}

class SplashLoadedState extends SplashState {
  @override
  List<Object> get props => [];
}

abstract class SplashEvent extends Equatable {
  const SplashEvent();
}

class LoadSplashScreenEvent extends SplashEvent {
  @override
  List<Object> get props => [];
}
