part of 'tv_show_top_rated_cubit.dart';

abstract class TvShowTopRatedState extends Equatable {
  const TvShowTopRatedState();

  @override
  List<Object> get props => [];
}

class TvShowTopRatedInitial extends TvShowTopRatedState {}

class TvShowTopRatedLoading extends TvShowTopRatedState {}

class TvShowTopRatedFailure extends TvShowTopRatedState {
  const TvShowTopRatedFailure(this.message);

  final String? message;
}

class TvShowTopRatedSuccess extends TvShowTopRatedState {
  const TvShowTopRatedSuccess(this.data);

  final List<MovieEntity> data;
}
