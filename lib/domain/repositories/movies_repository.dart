import 'package:dartz/dartz.dart';
import 'package:movie_app/core/error/failure.dart';
import 'package:movie_app/data/models/models.dart';
import 'package:movie_app/domain/entities/entities.dart';

abstract class MoviesRepository {
  Future<Either<Failure, ListMovieEntity>> getMoviesNowPlaying(
    MovieQueryParameter params,
  );
}
