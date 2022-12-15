part of 'movies_popular_cubit.dart';

abstract class MoviesPopularState extends Equatable {
  const MoviesPopularState();

  @override
  List<Object> get props => [];
}

class MoviesPopularInitial extends MoviesPopularState {}

class MoviesPopularLoading extends MoviesPopularState {}

class MoviesPopularFailure extends MoviesPopularState {
  const MoviesPopularFailure(this.message);

  final String? message;
}

class MoviesPopularSuccess extends MoviesPopularState {
  const MoviesPopularSuccess(this.data);

  final List<MovieEntity> data;
}
