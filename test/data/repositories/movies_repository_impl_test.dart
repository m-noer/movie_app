import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app/core/error/failure.dart';
import 'package:movie_app/data/data_sources/movies_remote_data_source.dart';
import 'package:movie_app/data/repositories/movies_repository_impl.dart';
import 'package:movie_app/domain/entities/entities.dart';

import '../../domain/use_cases/movies/get_movies_now_playing_use_case_test.dart';

class MockMovieRemoteDataSource extends Mock implements MoviesRemoteDataSource {
}

void main() {
  group('Movie repository test', () {
    final mockMovieRemoteDataSource = MockMovieRemoteDataSource();

    test('get movies now playing return ListMovieEntity', () async {
      final repository = MoviesRepositoryImpl(mockMovieRemoteDataSource);

      // arrange
      when(
        () => mockMovieRemoteDataSource.getMoviesNowPlaying(movieQuery),
      ).thenAnswer((invocation) => Future.value(listMovieEntity));

      // act
      final result = await repository.getMoviesNowPlaying(movieQuery);

      // assert
      expect(result, const Right<dynamic, ListMovieEntity>(listMovieEntity));
    });

    test('get movies now playing fail', () async {
      final repository = MoviesRepositoryImpl(mockMovieRemoteDataSource);

      final errorResponse = {
        'status_message': 'The resource you requested could not be found.',
        'status_code': 34
      };

      final response = Response<Map<String, dynamic>>(
        requestOptions: RequestOptions(path: 'path'),
        data: errorResponse,
        statusMessage: 'error',
      );

      // arrange
      when(
        () => mockMovieRemoteDataSource.getMoviesNowPlaying(movieQuery),
      ).thenThrow(
        DioError(
          requestOptions: RequestOptions(path: 'path'),
          response: response,
        ),
      );

      // act
      final result = await repository.getMoviesNowPlaying(movieQuery);

      // assert
      expect(result, isA<Left<Failure, ListMovieEntity>>());
    });

    test('get movies top rated return ListMovieEntity', () async {
      final repository = MoviesRepositoryImpl(mockMovieRemoteDataSource);

      // arrange
      when(
        () => mockMovieRemoteDataSource.getMoviesTopRated(movieQuery),
      ).thenAnswer((invocation) => Future.value(listMovieEntity));

      // act
      final result = await repository.getMoviesTopRated(movieQuery);

      // assert
      expect(result, const Right<dynamic, ListMovieEntity>(listMovieEntity));
    });

    test('get movies top rated fail', () async {
      final repository = MoviesRepositoryImpl(mockMovieRemoteDataSource);

      final errorResponse = {
        'status_message': 'The resource you requested could not be found.',
        'status_code': 34
      };

      final response = Response<Map<String, dynamic>>(
        requestOptions: RequestOptions(path: 'path'),
        data: errorResponse,
        statusMessage: 'error',
      );

      // arrange
      when(
        () => mockMovieRemoteDataSource.getMoviesTopRated(movieQuery),
      ).thenThrow(
        DioError(
          requestOptions: RequestOptions(path: 'path'),
          response: response,
        ),
      );

      // act
      final result = await repository.getMoviesTopRated(movieQuery);

      // assert
      expect(result, isA<Left<Failure, ListMovieEntity>>());
    });

    test('get movies popular return ListMovieEntity', () async {
      final repository = MoviesRepositoryImpl(mockMovieRemoteDataSource);

      // arrange
      when(
        () => mockMovieRemoteDataSource.getMoviesPopular(movieQuery),
      ).thenAnswer((invocation) => Future.value(listMovieEntity));

      // act
      final result = await repository.getMoviesPopular(movieQuery);

      // assert
      expect(result, const Right<dynamic, ListMovieEntity>(listMovieEntity));
    });

    test('get movies popular fail', () async {
      final repository = MoviesRepositoryImpl(mockMovieRemoteDataSource);

      final errorResponse = {
        'status_message': 'The resource you requested could not be found.',
        'status_code': 34
      };

      final response = Response<Map<String, dynamic>>(
        requestOptions: RequestOptions(path: 'path'),
        data: errorResponse,
        statusMessage: 'error',
      );

      // arrange
      when(
        () => mockMovieRemoteDataSource.getMoviesPopular(movieQuery),
      ).thenThrow(
        DioError(
          requestOptions: RequestOptions(path: 'path'),
          response: response,
        ),
      );

      // act
      final result = await repository.getMoviesPopular(movieQuery);

      // assert
      expect(result, isA<Left<Failure, ListMovieEntity>>());
    });

    test('get movies upcoming return ListMovieEntity', () async {
      final repository = MoviesRepositoryImpl(mockMovieRemoteDataSource);

      // arrange
      when(
        () => mockMovieRemoteDataSource.getMoviesUpcoming(movieQuery),
      ).thenAnswer((invocation) => Future.value(listMovieEntity));

      // act
      final result = await repository.getMoviesUpcoming(movieQuery);

      // assert
      expect(result, const Right<dynamic, ListMovieEntity>(listMovieEntity));
    });

    test('get movies upcoming fail', () async {
      final repository = MoviesRepositoryImpl(mockMovieRemoteDataSource);

      final errorResponse = {
        'status_message': 'The resource you requested could not be found.',
        'status_code': 34
      };

      final response = Response<Map<String, dynamic>>(
        requestOptions: RequestOptions(path: 'path'),
        data: errorResponse,
        statusMessage: 'error',
      );

      // arrange
      when(
        () => mockMovieRemoteDataSource.getMoviesUpcoming(movieQuery),
      ).thenThrow(
        DioError(
          requestOptions: RequestOptions(path: 'path'),
          response: response,
        ),
      );

      // act
      final result = await repository.getMoviesUpcoming(movieQuery);

      // assert
      expect(result, isA<Left<Failure, ListMovieEntity>>());
    });

    test('get detail movies return DetailMovieEntity', () async {
      final repository = MoviesRepositoryImpl(mockMovieRemoteDataSource);

      const detailMovieEntity = DetailMovieEntity(
        adult: false,
        backdropPath: 'backdropPath',
        budget: 100,
        genres: [],
        homepage: 'homepage',
        id: 1,
        imdbId: 'imdbId',
        originalLanguage: 'originalLanguage',
        originalTitle: 'originalTitle',
        overview: 'overview',
        popularity: 8,
        posterPath: 'posterPath',
        productionCompanies: [],
        releaseDate: 'releaseDate',
        revenue: 100,
        runtime: 100,
        status: 'status',
        tagline: 'tagline',
        title: 'title',
        video: true,
        voteAverage: 9,
        voteCount: 200,
      );

      // arrange
      when(
        () => mockMovieRemoteDataSource.getDetailMovie(1),
      ).thenAnswer((invocation) => Future.value(detailMovieEntity));

      // act
      final result = await repository.getDetailMovie(1);

      // assert
      expect(
        result,
        const Right<dynamic, DetailMovieEntity>(detailMovieEntity),
      );
    });

    test('get detail movies fail', () async {
      final repository = MoviesRepositoryImpl(mockMovieRemoteDataSource);

      final errorResponse = {
        'status_message': 'The resource you requested could not be found.',
        'status_code': 34
      };

      final response = Response<Map<String, dynamic>>(
        requestOptions: RequestOptions(path: 'path'),
        data: errorResponse,
        statusMessage: 'error',
      );

      // arrange
      when(
        () => mockMovieRemoteDataSource.getDetailMovie(1),
      ).thenThrow(
        DioError(
          requestOptions: RequestOptions(path: 'path'),
          response: response,
        ),
      );

      // act
      final result = await repository.getDetailMovie(1);

      // assert
      expect(result, isA<Left<Failure, DetailMovieEntity>>());
    });
  });
}
