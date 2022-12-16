import 'package:dartz/dartz.dart';
import 'package:movie_app/core/error/failure.dart';
import 'package:movie_app/core/usecases/usecase.dart';
import 'package:movie_app/domain/entities/entities.dart';
import 'package:movie_app/domain/repositories/tv_show_repository.dart';

class GetDetailTvShowUseCase extends UseCase<DetailTvShowEntity, int> {
  GetDetailTvShowUseCase(this.repository);

  final TvShowRepository repository;

  @override
  Future<Either<Failure, DetailTvShowEntity>> call(int params) {
    return repository.getDetailTvShow(params);
  }
}
