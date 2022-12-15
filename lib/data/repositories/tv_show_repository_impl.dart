import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:movie_app/core/error/failure.dart';
import 'package:movie_app/data/data_sources/tv_show_remote_data_source.dart';
import 'package:movie_app/data/models/models.dart';
import 'package:movie_app/domain/entities/detail_movie_entity.dart';
import 'package:movie_app/domain/entities/list_movie_entity.dart';
import 'package:movie_app/domain/repositories/tv_show_repository.dart';

class TvShowRepositoryImpl implements TvShowRepository {
  TvShowRepositoryImpl(this.remoteDataSource);

  final TvShowRemoteDataSource remoteDataSource;

  @override
  Future<Either<Failure, ListMovieEntity>> getTvShowOnAir(
    MovieQueryParameter params,
  ) async {
    try {
      final remoteData = await remoteDataSource.getTvShowOnAir(params);
      return Right(remoteData);
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        return Left(Failure.fromJson(e.response!.data as Map<String, dynamic>));
      } else {
        // Something happened in setting up or sending the request
        //that triggered an Error
        return Left(Failure(statusMessage: e.message));
      }
    } catch (e) {
      return Left(Failure(statusMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ListMovieEntity>> getTvShowTopRated(
    MovieQueryParameter params,
  ) async {
    try {
      final remoteData = await remoteDataSource.getTvShowTopRated(params);
      return Right(remoteData);
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        return Left(Failure.fromJson(e.response!.data as Map<String, dynamic>));
      } else {
        // Something happened in setting up or sending the request
        //that triggered an Error
        return Left(Failure(statusMessage: e.message));
      }
    } catch (e) {
      return Left(Failure(statusMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, DetailMovieEntity>> getDetailTvShow(int id) async {
    try {
      final remoteData = await remoteDataSource.getDetailTvShow(id);
      return Right(remoteData);
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        return Left(Failure.fromJson(e.response!.data as Map<String, dynamic>));
      } else {
        // Something happened in setting up or sending the request
        //that triggered an Error
        return Left(Failure(statusMessage: e.message));
      }
    } catch (e) {
      return Left(Failure(statusMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ListMovieEntity>> getTvShowAiringToday(
    MovieQueryParameter params,
  ) async {
    try {
      final remoteData = await remoteDataSource.getTvShowAiringToday(params);
      return Right(remoteData);
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        return Left(Failure.fromJson(e.response!.data as Map<String, dynamic>));
      } else {
        // Something happened in setting up or sending the request
        //that triggered an Error
        return Left(Failure(statusMessage: e.message));
      }
    } catch (e) {
      return Left(Failure(statusMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ListMovieEntity>> getTvShowPopular(
    MovieQueryParameter params,
  ) async {
    try {
      final remoteData = await remoteDataSource.getTvShowPopular(params);
      return Right(remoteData);
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        return Left(Failure.fromJson(e.response!.data as Map<String, dynamic>));
      } else {
        // Something happened in setting up or sending the request
        //that triggered an Error
        return Left(Failure(statusMessage: e.message));
      }
    } catch (e) {
      return Left(Failure(statusMessage: e.toString()));
    }
  }
}
