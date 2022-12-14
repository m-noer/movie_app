part of 'movies_now_playing_cubit.dart';

abstract class MoviesNowPlayingState extends Equatable {
  const MoviesNowPlayingState();

  @override
  List<Object> get props => [];
}

class MoviesNowPlayingInitial extends MoviesNowPlayingState {}

class MoviesNowPlayingLoading extends MoviesNowPlayingState {}

class MoviesNowPlayingFailure extends MoviesNowPlayingState {
  const MoviesNowPlayingFailure(this.message);

  final String? message;
}

class MoviesNowPlayingSuccess extends MoviesNowPlayingState {
  const MoviesNowPlayingSuccess(this.data);

  final List<MovieEntity> data;
}
