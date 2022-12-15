part of 'movies_top_rated_cubit.dart';

abstract class MoviesTopRatedState extends Equatable {
  const MoviesTopRatedState();

  @override
  List<Object> get props => [];
}

class MoviesTopRatedInitial extends MoviesTopRatedState {}

class MoviesTopRatedLoading extends MoviesTopRatedState {}

class MoviesTopRatedFailure extends MoviesTopRatedState {
  const MoviesTopRatedFailure(this.message);

  final String? message;
}

class MoviesTopRatedSuccess extends MoviesTopRatedState {
  const MoviesTopRatedSuccess(this.data);

  final List<MovieEntity> data;
}
