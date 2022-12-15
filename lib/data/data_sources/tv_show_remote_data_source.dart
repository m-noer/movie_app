import 'package:dio/dio.dart';
import 'package:movie_app/core/constants/api_path.dart';
import 'package:movie_app/core/error/exceptions.dart';
import 'package:movie_app/data/models/models.dart';
import 'package:movie_app/domain/entities/entities.dart';

abstract class TvShowRemoteDataSource {
  Future<ListMovieEntity> getTvShowOnAir(MovieQueryParameter params);
  Future<ListMovieEntity> getTvShowTopRated(MovieQueryParameter params);
  Future<ListMovieEntity> getTvShowAiringToday(MovieQueryParameter params);
  Future<ListMovieEntity> getTvShowPopular(MovieQueryParameter params);
  Future<DetailMovieEntity> getDetailTvShow(int id);
}

class TvShowRemoteDataSourceImpl extends TvShowRemoteDataSource {
  TvShowRemoteDataSourceImpl(this.dio);

  final Dio dio;

  @override
  Future<ListMovieEntity> getTvShowOnAir(
    MovieQueryParameter params,
  ) async {
    try {
      final response = await dio.get<Map<String, dynamic>>(
        ApiPath.tvOnAir,
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
  Future<ListMovieEntity> getTvShowTopRated(MovieQueryParameter params) async {
    try {
      final response = await dio.get<Map<String, dynamic>>(
        ApiPath.tvTopRated,
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
  Future<DetailMovieEntity> getDetailTvShow(int id) async {
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

  @override
  Future<ListMovieEntity> getTvShowAiringToday(
    MovieQueryParameter params,
  ) async {
    try {
      final response = await dio.get<Map<String, dynamic>>(
        ApiPath.tvAiringToday,
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
  Future<ListMovieEntity> getTvShowPopular(MovieQueryParameter params) async {
    try {
      final response = await dio.get<Map<String, dynamic>>(
        ApiPath.tvPopular,
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
}
