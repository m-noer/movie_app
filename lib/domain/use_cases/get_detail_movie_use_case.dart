import 'package:dartz/dartz.dart';
import 'package:movie_app/core/error/failure.dart';
import 'package:movie_app/core/usecases/usecase.dart';
import 'package:movie_app/domain/entities/entities.dart';
import 'package:movie_app/domain/repositories/movies_repository.dart';

class GetDetailMovieUseCase extends UseCase<DetailMovieEntity, int> {
  GetDetailMovieUseCase(this.repository);

  final MoviesRepository repository;

  @override
  Future<Either<Failure, DetailMovieEntity>> call(int params) {
    return repository.getDetailMovie(params);
  }
}
