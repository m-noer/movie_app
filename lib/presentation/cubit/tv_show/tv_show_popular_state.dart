part of 'tv_show_popular_cubit.dart';

abstract class TvShowPopularState extends Equatable {
  const TvShowPopularState();

  @override
  List<Object> get props => [];
}

class TvShowPopularInitial extends TvShowPopularState {}

class TvShowPopularLoading extends TvShowPopularState {}

class TvShowPopularFailure extends TvShowPopularState {
  const TvShowPopularFailure(this.message);

  final String? message;
}

class TvShowPopularSuccess extends TvShowPopularState {
  const TvShowPopularSuccess(this.data);

  final List<MovieEntity> data;
}
