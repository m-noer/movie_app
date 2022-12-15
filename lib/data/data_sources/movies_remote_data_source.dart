import 'package:dio/dio.dart';
import 'package:movie_app/core/constants/api_path.dart';
import 'package:movie_app/core/error/exceptions.dart';
import 'package:movie_app/data/models/models.dart';
import 'package:movie_app/domain/entities/entities.dart';

abstract class MoviesRemoteDataSource {
  Future<ListMovieEntity> getMoviesNowPlaying(MovieQueryParameter params);
  Future<ListMovieEntity> getMoviesTopRated(MovieQueryParameter params);
  Future<DetailMovieEntity> getDetailMovie(int id);
}

class MoviesRemoteDataSourceImpl extends MoviesRemoteDataSource {
  MoviesRemoteDataSourceImpl(this.dio);

  final Dio dio;

  @override
  Future<ListMovieEntity> getMoviesNowPlaying(
      MovieQueryParameter params) async {
    try {
      final response = await dio.get<Map<String, dynamic>>(
        ApiPath.moviesNowPlaying,
        queryParameters: params.toJson(),
      );
      return ListMovieModel.fromJson(response.data!);
    } on DioError catch (e) {
      throw DioError(
        requestOptions: e.requestOptions,
        error: e.error,
        response: e.response,
      );
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<ListMovieEntity> getMoviesTopRated(MovieQueryParameter params) async {
    try {
      final response = await dio.get<Map<String, dynamic>>(
        ApiPath.moviesTopRated,
        queryParameters: params.toJson(),
      );
      return ListMovieModel.fromJson(response.data!);
    } on DioError catch (e) {
      throw DioError(
        requestOptions: e.requestOptions,
        error: e.error,
        response: e.response,
      );
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<DetailMovieEntity> getDetailMovie(int id) async {
    try {
      final response = await dio.get<Map<String, dynamic>>(
        '${ApiPath.movie}/$id',
      );
      return DetailMovieModel.fromJson(response.data!);
    } on DioError catch (e) {
      throw DioError(
        requestOptions: e.requestOptions,
        error: e.error,
        response: e.response,
      );
    } catch (e) {
      throw ServerException();
    }
  }
}
