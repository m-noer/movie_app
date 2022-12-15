part of 'tv_show_airing_today_cubit.dart';

abstract class TvShowAiringTodayState extends Equatable {
  const TvShowAiringTodayState();

  @override
  List<Object> get props => [];
}

class TvShowAiringTodayInitial extends TvShowAiringTodayState {}

class TvShowAiringTodayLoading extends TvShowAiringTodayState {}

class TvShowAiringTodayFailure extends TvShowAiringTodayState {
  const TvShowAiringTodayFailure(this.message);

  final String? message;
}

class TvShowAiringTodaySuccess extends TvShowAiringTodayState {
  const TvShowAiringTodaySuccess(this.data);

  final List<MovieEntity> data;
}
