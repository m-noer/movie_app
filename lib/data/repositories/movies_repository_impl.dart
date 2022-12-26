import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:movie_app/core/error/failure.dart';
import 'package:movie_app/data/data_sources/movies_remote_data_source.dart';
import 'package:movie_app/data/models/models.dart';
import 'package:movie_app/domain/entities/detail_movie_entity.dart';
import 'package:movie_app/domain/entities/list_movie_entity.dart';
import 'package:movie_app/domain/repositories/movies_repository.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  MoviesRepositoryImpl(this.remoteDataSource);

  final MoviesRemoteDataSource remoteDataSource;

  @override
  Future<Either<Failure, ListMovieEntity>> getMoviesNowPlaying(
    MovieQueryParameter params,
  ) async {
    try {
      final remoteData = await remoteDataSource.getMoviesNowPlaying(params);
      return Right(remoteData);
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.

      return Left(Failure.fromJson(e.response?.data as Map<String, dynamic>));
    } catch (e) {
      return const Left(Failure(statusMessage: 'Error'));
    }
  }

  @override
  Future<Either<Failure, ListMovieEntity>> getMoviesTopRated(
    MovieQueryParameter params,
  ) async {
    try {
      final remoteData = await remoteDataSource.getMoviesTopRated(params);
      return Right(remoteData);
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.

      return Left(Failure.fromJson(e.response?.data as Map<String, dynamic>));
    } catch (e) {
      return const Left(Failure(statusMessage: 'Error'));
    }
  }

  @override
  Future<Either<Failure, DetailMovieEntity>> getDetailMovie(int id) async {
    try {
      final remoteData = await remoteDataSource.getDetailMovie(id);
      return Right(remoteData);
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.

      return Left(Failure.fromJson(e.response?.data as Map<String, dynamic>));
    } catch (e) {
      return const Left(Failure(statusMessage: 'Error'));
    }
  }

  @override
  Future<Either<Failure, ListMovieEntity>> getMoviesUpcoming(
    MovieQueryParameter params,
  ) async {
    try {
      final remoteData = await remoteDataSource.getMoviesUpcoming(params);
      return Right(remoteData);
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.

      return Left(Failure.fromJson(e.response?.data as Map<String, dynamic>));
    } catch (e) {
      return const Left(Failure(statusMessage: 'Error'));
    }
  }

  @override
  Future<Either<Failure, ListMovieEntity>> getMoviesPopular(
    MovieQueryParameter params,
  ) async {
    try {
      final remoteData = await remoteDataSource.getMoviesPopular(params);
      return Right(remoteData);
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.

      return Left(Failure.fromJson(e.response?.data as Map<String, dynamic>));
    } catch (e) {
      return const Left(Failure(statusMessage: 'Error'));
    }
  }
}
