part of 'movies_upcoming_cubit.dart';

abstract class MoviesUpcomingState extends Equatable {
  const MoviesUpcomingState();

  @override
  List<Object> get props => [];
}

class MoviesUpcomingInitial extends MoviesUpcomingState {}

class MoviesUpcomingLoading extends MoviesUpcomingState {}

class MoviesUpcomingFailure extends MoviesUpcomingState {
  const MoviesUpcomingFailure(this.message);

  final String? message;
}

class MoviesUpcomingSuccess extends MoviesUpcomingState {
  const MoviesUpcomingSuccess(this.data);

  final List<MovieEntity> data;
}
