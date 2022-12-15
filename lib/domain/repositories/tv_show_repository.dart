import 'package:dartz/dartz.dart';
import 'package:movie_app/core/error/failure.dart';
import 'package:movie_app/data/models/models.dart';
import 'package:movie_app/domain/entities/entities.dart';

abstract class TvShowRepository {
  Future<Either<Failure, ListMovieEntity>> getTvShowOnAir(
    MovieQueryParameter params,
  );
  Future<Either<Failure, ListMovieEntity>> getTvShowTopRated(
    MovieQueryParameter params,
  );
  Future<Either<Failure, ListMovieEntity>> getTvShowAiringToday(
    MovieQueryParameter params,
  );
  Future<Either<Failure, ListMovieEntity>> getTvShowPopular(
    MovieQueryParameter params,
  );
  Future<Either<Failure, DetailMovieEntity>> getDetailTvShow(int id);
}
