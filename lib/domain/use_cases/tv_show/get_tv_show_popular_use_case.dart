import 'package:dartz/dartz.dart';
import 'package:movie_app/core/error/failure.dart';
import 'package:movie_app/core/usecases/usecase.dart';
import 'package:movie_app/data/models/models.dart';
import 'package:movie_app/domain/entities/entities.dart';
import 'package:movie_app/domain/repositories/tv_show_repository.dart';

class GetTvShowPopularUseCase
    extends UseCase<ListMovieEntity, MovieQueryParameter> {
  GetTvShowPopularUseCase(this.repository);

  final TvShowRepository repository;

  @override
  Future<Either<Failure, ListMovieEntity>> call(MovieQueryParameter params) {
    return repository.getTvShowPopular(params);
  }
}
