part of 'tv_show_on_air_cubit.dart';

abstract class TvShowOnAirState extends Equatable {
  const TvShowOnAirState();

  @override
  List<Object> get props => [];
}

class TvShowOnAirInitial extends TvShowOnAirState {}

class TvShowOnAirLoading extends TvShowOnAirState {}

class TvShowOnAirFailure extends TvShowOnAirState {
  const TvShowOnAirFailure(this.message);

  final String? message;
}

class TvShowOnAirSuccess extends TvShowOnAirState {
  const TvShowOnAirSuccess(this.data);

  final List<MovieEntity> data;
}
