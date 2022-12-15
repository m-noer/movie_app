part of 'detail_movie_cubit.dart';

abstract class DetailMovieState extends Equatable {
  const DetailMovieState();

  @override
  List<Object> get props => [];
}

class DetailMovieInitial extends DetailMovieState {}

class DetailMovieLoading extends DetailMovieState {}

class DetailMovieFailure extends DetailMovieState {
  const DetailMovieFailure(this.message);

  final String? message;
}

class DetailMovieSuccess extends DetailMovieState {
  const DetailMovieSuccess(this.data);

  final DetailMovieEntity data;
}
