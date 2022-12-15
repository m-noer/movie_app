import 'package:dartz/dartz.dart';
import 'package:movie_app/core/error/failure.dart';
import 'package:movie_app/core/usecases/usecase.dart';
import 'package:movie_app/data/models/models.dart';
import 'package:movie_app/domain/entities/entities.dart';
import 'package:movie_app/domain/repositories/movies_repository.dart';

class GetMoviesTopRatedUseCase
    extends UseCase<ListMovieEntity, MovieQueryParameter> {
  GetMoviesTopRatedUseCase(this.repository);

  final MoviesRepository repository;

  @override
  Future<Either<Failure, ListMovieEntity>> call(MovieQueryParameter params) {
    return repository.getMoviesTopRated(params);
  }
}
